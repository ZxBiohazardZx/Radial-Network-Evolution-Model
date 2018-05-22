% CALCSCORE Calculate Expansion Candidate Scores based on Properties
% Filename: CalcScore.m
%
% Description:
%     Given candidate properties calculate the score of each candidate, the
%     expected userbenefits, operatorcosts and ridership
% Author:
%     Alex Vermeulen
%     zxbiohazardzx@gmail.com
% Inputs:
%     [Candidate] Structure containing single investment Candidate
%     [CurCosts] Shortest Path Matrix [km] for current network
%     [ODMatrix] Trip / Demand Matrix for all OD Pairs
%     [MinTravelDist] Shortest Path Matrix [km] for the Max Planar Graph
%     [VMode] Mode Operational Speed
%     [VAlt]  Alternative Travel Speed
%     [Alpha] Investment Cost / km
%     [VOT] Value of Time 
%     [LBeta] Commonly 1, logit function steering function, passable
%     variable
% Outputs:
%     [Score] The Benefit/Cost Ratio for the input Candidate
%     [UserBenefits] UserBenefits Monetised
%     [OperatorCosts] Operational/Construction Costs Monetised
%     [Ridership] Calculated expected Ridership (Unconstrained/No Capacity)
% SubFunctions:
%     calcUserBenefits(Candidate,CurCosts,ODMatrix,MinTravelDist,VMode,VAlt,LBeta)
%     calcOperatorCosts(Candidate,Alpha)
% Usage:
%     [Score,UserBenefits,OperatorCosts,Ridership] = CalcScore(Candidate,CurCosts,ODMatrix,MinTravelDist,VMode,VAlt,Alpha,VOT,LBeta)
%
function [Score,UserBen,OperCosts,Ridership] = CalcScore(Candidate,CurCosts,ODMatrix,MinTravelDist,VMode,VAlt,Alpha,VOT,LBeta)
    % http://ec.europa.eu/regional_policy/sources/docgener/studies/pdf/cba_guide.pdf    
    % TimeHorizonCorrect=262974; % Hours in 30 years (Investment Horizon EU) * TimeHorizonCorrect
    %UserBenefits = VOT * DeltaTT * TimeHorizonCorrect;  % Userbenefits are the Value of Time * TravelTime Change
    
    
    % First Call Functions to Determine the Ridership, TravelTime Savings and Operator Costs for a given Candidate.
    [Ridership,DeltaTT]=calcUserBenefits(Candidate,CurCosts,ODMatrix,MinTravelDist,VMode,VAlt,LBeta);
    OperatorCosts = calcOperatorCosts(Candidate,Alpha); % OperatorCosts are direct output from function
    
    %Investment has 30 years to return itself in benefits (EU)
    UserBen=VOT*DeltaTT*8760; % UserBenefits are measured in TravelTime reduction [hours]*[Money/hour]*[Hour/Year]
    %UserBenefits are Annual Benefits for 30 years
    A=UserBen*ones(1,30);A(1)=0; % Create Array & Assing Benefits first year as 0
    UserBen=pvvar(A,0.05);       % Apply Net Present Value Function @ 5% Rate (Common value)

    %Operator Costs have the same functionality: 
    B=zeros(1,30);B(1)=-OperatorCosts; % Create Array & Assing Costs non-year1 as 0
    OperCosts=pvvar(B,0.05);     % Apply Net Present Value Function @ 5% Rate (Common value)

    % Scoring Method: CBA with Discounted Benefits and Discounted Costs
    if UserBen > abs(OperCosts) 
        Score = UserBen / abs(OperCosts); % Score = Benefits / Costs
    else
        Score = -1;
    end
end

%--------------------------------
%-- Function calcOperatorCosts --
%--------------------------------
%calcOperatorCosts: Calculates the operator costs based on the Candidate
%information. OperatorCosts Alpha * NewLinkLength
function OperCost = calcOperatorCosts(Candidate,Alpha)
    % Only possible if the NewLinkLength > 0
    if Candidate.NewLinkLength >0
        OperCost= Alpha * Candidate.NewLinkLength; %Length = Cost!?
    else
        OperCost= -1; %DEBUG VALUE
    end
end

%----------------------------
%-- Function calcUserCosts --
%----------------------------
% Traveltime is in Hours; Users are Trips [Persons], Resulting in [PersonHours]
% Sumation of (Delta) TotalTravelTime is the Benefit for all users[PersonHours]
function [Ridership,DeltaTT] = calcUserBenefits(Candidate,CurCosts,ODMatrix,MinTravelDist,VMode,VAlt,LBeta)

% Calculate Traveltimes = (Distance / Speed)  [hours] 
TT_Alt    = (MinTravelDist ./ VAlt);       %in HOURS
TT_PT_Cur = (CurCosts ./ VMode);        %in HOURS
TT_PT_New = (Candidate.Costs ./ VMode); %in HOURS

% Calculate the Modal Split for both scenarios [%,%]
[AltShare_Cur,PTShare_Cur]=logitUtility(LBeta,TT_Alt,TT_PT_Cur);
[AltShare_New,PTShare_New]=logitUtility(LBeta,TT_Alt,TT_PT_New);

%Calculate TripCounts (Multiply Respective Share with the ODMatrix) [Persons]
Users_Alt_Cur = AltShare_Cur .* ODMatrix;
Users_PT_Cur  = PTShare_Cur  .* ODMatrix;
Users_Alt_New = AltShare_New .* ODMatrix;
Users_PT_New  = PTShare_New  .* ODMatrix;

%Replace NAN entries with 0 (Self-Travel mostly)(if applicable)-(Safety/Debug)
Users_Alt_Cur(isnan(Users_Alt_Cur))=0;
Users_Alt_New(isnan(Users_Alt_New))=0;
Users_PT_Cur(isnan(Users_PT_Cur))=0;
Users_PT_New(isnan(Users_PT_New))=0;

% Determine TotalTravelTime for Users [PersonHours]
% Ensure all elements are finite before doing mathematical operations
TT_PT_Cur(~isfinite(TT_PT_Cur))=0; % Set infinity to 0 as Inf*0 = NaN
TT_PT_New(~isfinite(TT_PT_New))=0; % Set infinity to 0 as Inf*0 = NaN

% Calculate System TotalTravelTime in [PersonHours]
TT_Cur = (TT_Alt .* Users_Alt_Cur) + (TT_PT_Cur .* Users_PT_Cur);
TT_New = (TT_Alt .* Users_Alt_New) + (TT_PT_New .* Users_PT_New);

%Summate them for difference
TTT_Cur = sum(sum(TT_Cur),2);
TTT_New = sum(sum(TT_New),2);

% Benefits are the network effects on traveltimes (Negative = REDUCTION)
DeltaTT = (TTT_New) - (TTT_Cur);
%Additionally output the PT Ridership for KPI?
Ridership = sum(sum(Users_PT_New));

end