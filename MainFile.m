%Ring Radial Network Growth Evolution Model%
clc;
clear variables; % disable for iterative addition!
close all; %close all figure objects.
tic  %help time the program
% ----------------------------
% -- INPUT VARIALBES / GRID --
% ----------------------------
% -- Grid Definition
R=40;        %radius (Km)
phi_deg=30;  %Radial Offset Angle (DEGREES)
S=8;         %Number ofRings (spaced R/S)  
% -- Derived Variables -- 
phi=deg2rad(phi_deg);   %angle phi in radians
VMode = 35; VAlt=25;    % Operational Speeds [km/h] (35/45/60)
Beta = (VMode/VAlt);    % Ratio
Alpha = 300E6;            % Cost factor for Mode (E6=MLN)     (6/20/300) [MONEY   / KM] 
CapValue = 8000;        % Set Capacity for a single link (increment) [PEAKCAP / HOUR]
MaxCapacity = 80000;    % Maximum Capacity Value?
Pop_Dist = 1;           % 1 = Uniform 2 = Linear, 3 = Exponential %(Can be user input)
%Mode_type = 1;          % 1= BRT, 2=LRT, 3=Metro (NOT IMPLEMENTED YET)
VOT=-8.75;              % Value of Time                              [MONEY   / HOUR]
LBeta=1;                % Beta to steer Logit Model ([0.01 - 1])
Gravity_Mu = 2.5;        % Mu value to steer GravityModel
Gravity_Sigma = 1;    % Sigma value to steer GravityModel
% ----------------------------------------------------------------
% -- Define Node Spatial Distribution & Load Full Planar Graph  -- 
% ----------------------------------------------------------------
%Call function to build Polar Grid given R,phi,S (Scales for R/phi/S)
Nodes=GenerateGrid(R,phi,S,Pop_Dist); 
% Load Full Planar Graph Data
MPG_Links=MaxPlanarGraph(R,phi,S,Nodes);
[Distance,NetAdjMat]=NetworkMatrix(Nodes,MPG_Links);
[MinTravelDist,MPG_Paths] = dijkstra(NetAdjMat,Distance);
% ----------------------------
% -- Define Initial Network --
% ----------------------------
Links=struct('StartNode',[],'EndNode',[],'Length',[],'Usage',[]);% disable for iterative addition!
% Start Network: 1->2; 1-> 6; 1->10; (peace sign)
Links(1).StartNode=1;Links(1).EndNode=2;Links(1).Length=calcLinkLength(Nodes,Links(1));Links(1).Capacity=CapValue; 
Links(2).StartNode=1;Links(2).EndNode=6;Links(2).Length=calcLinkLength(Nodes,Links(2));Links(2).Capacity=CapValue;
Links(3).StartNode=1;Links(3).EndNode=10;Links(3).Length=calcLinkLength(Nodes,Links(3));Links(3).Capacity=CapValue;

% ---------------------
% -- ITERATION SETUP -- 
% ---------------------
prompt='maximum number of iterations requested?';
MaxIterations=input(prompt)+1;
%F(MaxIterations-1) = struct('cdata',[],'colormap',[]);
clear prompt;
History=struct('LinksAdded',[],'Score',0);
ii=1; %set loop counter to a value
[NetMat,AdjMat] = NetworkMatrix(Nodes,Links);
[CurCosts,CurPath] = dijkstra(AdjMat,NetMat);
Stop=0; %Biniary Stop Condition
CapacityTrue=0; %Initially false

% ---------------------
% -- TRIP GENERATION --
% ---------------------
% Given a population, apply GravityModel to calculate (Latent)Trip Matrix?
d_ij = GravityModel(MinTravelDist,Nodes,Gravity_Mu,Gravity_Sigma);
%d_ij=ones(numel(Nodes)).*(Population / numel(Nodes)); % Verification - DISABLE GRAVITY MODEL

% ---------------------
% -- TRIP ASSIGNMENT -- 
% ---------------------
%Calulate the Actual Share of Realised Demand:
TT_Alt=(MinTravelDist ./ VAlt);%in HOURS
TT_PT_Cur=(CurCosts ./ VMode); %in HOURS
% Calculate the Modal Split for both scenarios [%,%]
[AltShare_Cur,PTShare_Cur]=logitUtility(LBeta,TT_Alt,TT_PT_Cur);
%Calculate TripCounts (Multiply Respective Share with the ODMatrix) [Persons]
Users_Alt_Cur = AltShare_Cur .* d_ij; 
Users_PT_Cur  = PTShare_Cur  .* d_ij;
%Link Usage Determination Test (Uncapacitated Assignment)
Links=LinkLoad(Links,Users_PT_Cur,CurPath);

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------- MAIN ITERATIONS LOOP -------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%open(v);
while (ii < MaxIterations && Stop ==0)
    if ii==1
        Cur_TTT=0;
         Sel_Can_Expansion.Ridership=39642; % Set previous Expansion Score to -1 to reset it!
    end
    % ---------------------------------------
    % -- Generate Candidates for expansion --
    % ---------------------------------------
    if CapacityTrue==0 % We need to generate new Candidates
        %Generate Expansion Candidates; These candidates define new potential link (Start/Endnode)
        Candidate = genExpansionCandidates(NetAdjMat,AdjMat,Nodes,Links,CapValue);
    else % Capacity = True! -> We need to update candidate Links with new capacity
        %Update Candidate Link-List: saves a few dijkstras by just updating
        %link Capactity from Link Lib & re-adding the link for the candidate
        for a=1:1:numel(Candidate)
            Candidate(a).Links=Links;
            Candidate(a).Links = BuildLink(Candidate(a).StartNode,Candidate(a).EndNode,Nodes,Links,CapValue);
        end
    end
    % -----------------------------------------------
    % -- Generate Candidates for Capacity Increase --
    % -----------------------------------------------
    % Determine the Capacity Candidates by Evaluating Links (FunctionCall)
    Candidate2 = genCapacityCandidates(Links,CapValue,MaxCapacity); % This works now

    % ------------------------
    % -- Score & Evaluation --
    % ------------------------
    BestScore=0; %Set the best score to 0 or stop criterion.
    Sel_Can_Expansion.Score=-1; % Set previous Expansion Score to -1 to reset it!
    %Determine the Best Candidate. If equal score, keep first candidate
    for n=1:1:numel(Candidate)
        if(Candidate(n).StartNode < Candidate(n).EndNode)
            % Determine the Score, Benefits and Costs for Expansion Candidates
            [Candidate(n).Score,Candidate(n).UserBenefits,Candidate(n).OperCosts,Candidate(n).Ridership,Candidate(n).TTT]= calcScore(Candidate(n),CurCosts,d_ij,MinTravelDist,VMode,VAlt,Alpha,VOT,LBeta);
        else
            % This shouldnt happen, SWAPPED ENTRY & RECALCULATE? 
            Temp = Candidate(n).EndNode; Candidate(n).EndNode=Candidate(n).StartNode; Candidate(n).StartNode = Temp;
            clear Temp;
            Candidate(n) = calcCanProp(Candidate(n),Nodes,Links,CapValue);
            [Candidate(n).Score,Candidate(n).UserBenefits,Candidate(n).OperCosts,Candidate(n).Ridership,Candidate(n).TTT]= calcScore(Candidate(n),CurCosts,d_ij,MinTravelDist,VMode,VAlt,Alpha,VOT,LBeta);
        end
        %Then lets find the best Network Expansion Candidate Based on these parameters
        if Candidate(n).Score > 0 && Candidate(n).Score > BestScore && Stop==0
            BestScore=max(BestScore,Candidate(n).Score);
            Sel_Can_Expansion=Candidate(n);
        end
    end
    %Check if the Capacity Scores are better then the Expansion Scores: 
    % if DeniedCandidate2 > Denied -> Its better thus should be considered
    MaxDenied=0;
    MaxDeniedAfter=0;
    CapBestScore=0;
    Sel_Can_Capacity.Score=-1; % Set previous Expansion Score to -1 to reset it!
    for n=1:1:numel(Candidate2)
        % Following Cases: 
        % 1) DeniedAfter >= MaxDeniedAfter -> This is absolutely a candidate we want to consider
        if Candidate2(n).DeniedAfter >= MaxDeniedAfter && Stop ==0
            MaxDeniedAfter = Candidate2(n).DeniedAfter;
            %2) Denied > MaxDenied -> This is the best of the matching cases
            if Candidate2(n).Denied >= MaxDenied
                MaxDenied = Candidate2(n).Denied;
                [Candidate2(n).Benefits,Candidate2(n).Costs,Candidate2(n).Score]=calcCapScore2(Candidate2(n),Alpha,CapValue,VOT,VMode,VAlt,MaxCapacity);
                % Now that we preselected it, we should check the score!
                if Candidate2(n).Score > 0 && Candidate2(n).Score > CapBestScore
                    CapBestScore=max(CapBestScore,Candidate2(n).Score);
                    %Since this is the best Candidate at this moment, Store it
                    %as Sel_Can_Capacity
                    Sel_Can_Capacity.StartNode = Candidate2(n).StartNode;
                    Sel_Can_Capacity.EndNode = Candidate2(n).EndNode;
                    Sel_Can_Capacity.NewLinkLength = Candidate2(n).NewLinkLength;
                    Sel_Can_Capacity.Links = Candidate2(n).Links;
                    Sel_Can_Capacity.NetMat = NetMat;
                    Sel_Can_Capacity.Costs = CurCosts;
                    Sel_Can_Capacity.Score = Candidate2(n).Score;
                    Sel_Can_Capacity.paths = CurPath;
                    Sel_Can_Capacity.UserBenefits = Candidate2(n).Benefits;
                    Sel_Can_Capacity.OperCost = Candidate2(n).Costs;
                    Sel_Can_Capacity.Ridership = Sel_Can_Expansion.Ridership; %Maintain Ridership
                    Sel_Can_Capacity.TTT = Cur_TTT;
                end
            end
        end
    end
    
    BestScore=max(CapBestScore,BestScore);
   
    if Sel_Can_Expansion.Score > Sel_Can_Capacity.Score
        Sel_Can = Sel_Can_Expansion;
        % Expansion is better then increasing Capacity:
        CapacityTrue=0; %Not Capacity Thus set this to 0
        %For the best Expansion Candidate -> Determine Usage (Compare against capacity increase)
        %Calulate the Actual Share of Realised Demand:
        TT_Alt    = (MinTravelDist ./ VAlt);       %in HOURS
        TT_PT_Cur = (Sel_Can.Costs ./ VMode);        %in HOURS
        % Calculate the Modal Split for both scenarios [%,%]
        [AltShare_Cur,PTShare_Cur]=logitUtility(LBeta,TT_Alt,TT_PT_Cur);
        %Calculate TripCounts (Multiply Respective Share with the ODMatrix) [Persons]
        Users_Alt_Cur = AltShare_Cur .* d_ij;
        Users_PT_Cur  = PTShare_Cur  .* d_ij;
        Sel_Can.Links=LinkLoad(Sel_Can.Links,Users_PT_Cur,Sel_Can.paths);
        Links=Sel_Can.Links; %Copy the Link Library
        CurPath=Sel_Can.paths;
        CurCosts=Sel_Can.Costs; % Copy Cost Matrix
        [NetMat,AdjMat] = NetworkMatrix(Nodes,Links); % Update Adjacency Matrix
    else
        %Capacity is better then expansion
        CapacityTrue=1; %Set this to true / 1
        Sel_Can = Sel_Can_Capacity;
    end
    
    % -----------------------------------------------------------------
    % -- Construct the Selected Candidate && update network elements --
    % -----------------------------------------------------------------
    if BestScore==0
        Stop=1;
        disp('STOP ITERATIONS')
        break
    else    
        Links=Sel_Can.Links; %Copy the Link Library
        CurCosts=Sel_Can.Costs; % Copy Cost Matrix
        [NetMat,AdjMat] = NetworkMatrix(Nodes,Links); % Update Adjacency Matrix
        % Add an entry to the construction History
        History(ii).LinksAdded=[num2str(Sel_Can.StartNode),' to ',num2str(Sel_Can.EndNode)];
        % ---------------------------------------
        % -- Output Key Performance Indicators --
        % ---------------------------------------
        % Calculate Potentially interestingNetwork Output Indicators?
        History(ii).Score=Sel_Can.Score;
        History(ii).Links=Links;
        History(ii).UserBenefits=Sel_Can.UserBenefits;
        History(ii).Ridership=Sel_Can.Ridership;
        History(ii).Denied=sum([Sel_Can.Links.Usage]) - sum([Sel_Can.Links.Capacity]);
        [History(ii).Beta,History(ii).Gamma,History(ii).Diameter,History(ii).APL,History(ii).AvgDeg,History(ii).AvgBc,History(ii).sdDeg,History(ii).sdBc,History(ii).TLL,History(ii).Ringness,History(ii).Detour]=calcIndicators(NetAdjMat,AdjMat,NetMat,CurCosts,Nodes,Links,MinTravelDist);
        Cur_TTT=Sel_Can.TTT;
        History(ii).TTT=Sel_Can.TTT;
        History(ii).AverageLinkLoad=mean([Links.Usage]);
    end
    disp(["iteration:" num2str(ii)])
    %advance a timestep and continue the loop.
    ii=ii+1;
    toc
end
%Cleanup temp variables
clear ii;
clear BestScore;
clear TempCosts;
clear MaxIterations;
clear a;
clear b;
clear n;

% ------------------------------
% -- Output Final Network KPI --
% ------------------------------
% Calculate Network Output Indicators
%OutputIndicators = calcIndicators(NetAdjMat,AdjMat,NetMat,CurCosts,Nodes,Links);
AScore=0; 
for a=1:1:numel(History)
    AScore=AScore+History(a).Score;
    History(a).AScore=AScore;
end
History = AdditionalHistory(History);
% ---------------------------
% -- Visualise the network --
% ---------------------------
VisualiseNetwork(History,Nodes,History(end).Links,CapValue,MaxCapacity,R,phi,S);
toc 
