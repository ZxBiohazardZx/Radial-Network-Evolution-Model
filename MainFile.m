clc;
clear variables; % disable for iterative addition!
close all; %close all figure objects.
tic  %help time the program

% ----------------------------
% -- INPUT VARIALBES / GRID --
% ----------------------------
% -- Grid Definition
R=80;        %radius (Km)
phi_deg=30;  %Radial Offset Angle (DEGREES)
S=8;         %Number ofRings (spaced R/S)  
% -- Population / Demand Definition
%Population = 350; % Population PER NODE
% -- Derived Variables -- 
phi=deg2rad(phi_deg);   %angle phi in radians
VMode = 50; VAlt=30;    % Operational Speeds [km/h]
Beta = (VMode/VAlt);    % Ratio
Alpha = 35E6;           % Cost factor for Mode (E6=MLN)              [MONEY   / KM] 
CapValue = 5000;        % Set Capacity for a single link (increment) [PEAKCAP / HOUR]
MaxCapacity = 50000;    % Maximum Capacity Value?
VOT=-8.75;              % Value of Time                              [MONEY   / HOUR]
LBeta=1;                % Beta to steer Logit Model ([0.01 - 1])
Gravity_Mu = 10;        % Mu value to steer GravityModel
Gravity_Sigma = 0.5;    % Sigma value to steer GravityModel


% ----------------------------------------------------------------
% -- Define Node Spatial Distribution & Load Full Planar Graph  -- 
% ----------------------------------------------------------------
%Call function to build Polar Grid given R,phi,S (Scales for R/phi/S)
Nodes=GenerateGrid(R,phi,S); 
% Load Full Planar Graph Data
MPG_Links=MaxPlanarGraph(R,phi,S,Nodes);
[Distance,NetAdjMat]=NetworkMatrix(Nodes,MPG_Links);
[MinTravelDist,MPG_Paths] = dijkstra(NetAdjMat,Distance);
%---------------------------
%-- Population Definition -- 
%---------------------------
for a=1:1:numel(Nodes)
 Nodes(a).pop = 82500;                           % Uniform Population   ~ 8 mill
% Nodes(a).pop = 165000 - (Nodes(a).r / R)*145000; % Linear Decay Function ~ 8.175 mill
% Nodes(a).pop = 350000*exp(-Nodes(a).r/25);   %Exponential Decay Function  ~ 23,18 mill
 if a==1
     Nodes(a).pop=2*Nodes(a).pop;
 end
end

% ----------------------------
% -- Define Initial Network --
% ----------------------------
Links=struct('StartNode',[],'EndNode',[],'Length',[],'Usage',[]);% disable for iterative addition!
%Required Initial Network (At least 1 link buid?)
Links(1).StartNode=1;
Links(1).EndNode=2;
Links(1).Length=calcLinkLength(Nodes,Links(1));
Links(1).Capacity=CapValue; %BaseValue for Capacity
Links(2).StartNode=1;
Links(2).EndNode=6;
Links(2).Length=calcLinkLength(Nodes,Links(2));
Links(2).Capacity=CapValue; %BaseValue for Capacity
Links(3).StartNode=1;
Links(3).EndNode=10;
Links(3).Length=calcLinkLength(Nodes,Links(3));
Links(3).Capacity=CapValue; %BaseValue for Capacity

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
%v = VideoWriter('Test.avi');
%clf % Clear Figure Window (CLF)
% f1=figure('visible','off');
% DrawGrid(R,phi,S);


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------- MAIN ITERATIONS LOOP -------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
CapacityTrue=0; %Initially false!
% ---------------------
% -- TRIP GENERATION --
% ---------------------
% Given a population, apply GravityModel to calculate (Latent)Trip Matrix?
ODMATRIX = GravityModel(MinTravelDist,Nodes,Gravity_Mu,Gravity_Sigma);
d_ij = ODMATRIX;
%d_ij=ones(numel(Nodes)).*Population;
Links=LinkLoad(Links,ODMATRIX,CurPath); %New Usage Determination Test
%open(v);
% --------------------------------------------------
% -- Main File Loop to do interative construction --
% --------------------------------------------------
while (ii < MaxIterations && Stop ==0)
    % -----------------------------------------
    % -- Generate Alternatives for expansion --
    % -----------------------------------------
    if CapacityTrue==0
    %Generate new Connection Candidates
    % These candidates define new potential link (Start/Endnode)
    Candidate = GenerateCandidates (NetAdjMat,AdjMat);
    % Calculate Poperties for these Candidates (Links,NetMat,Costs)
        if numel(Candidate) >= 1
            Candidate = CalcCanProp(Candidate,Nodes,Links,MinTravelDist,CapValue);
        elseif numel(Candidate)==0 && isempty(Candidate(1).StartNode)
            Stop=1;
            disp('STOP ITERATIONS - NO CANDIDATE')
            break
        end
    else
        %remove the last capacity addition candidate if we just added that
        %Candidate(end)=[];
        %Update Candidate Link-List? saves a few dijkstras by just updating
        %link Capactity from Link Lib & re-adding the link for the
        %candidate
        for a=1:1:numel(Candidate)
            Candidate(a).Links=Links;
            Candidate(a).Links = BuildLink(Candidate(a).StartNode,Candidate(a).EndNode,Nodes,Links,CapValue);
        end
    end 
    %Add Capacity Candidate in the end!
    %Candidate = AddCapacityCandidate(Candidate,Links,Nodes,CapValue,MaxCapacity);
    Candidate2 = CapacityCandidates(Links,CapValue,MaxCapacity); % This works now
    for b=1:1:numel(Candidate2)
        [Candidate2(b).Benefits,Candidate2(b).Costs,Candidate2(b).Score]=calcCapScore(Candidate2(b),Links,Alpha,VOT);
    end
    % ---------------------------------
    % -- Select Investment Candidate --
    % ---------------------------------
    BestScore=0; %Set the best score to 0 or stop criterion.
    CapacityTrue=0; %Reset this Number
    %Determine the Best Candidate. If equal score, keep first candidate
    
    for n=1:1:numel(Candidate)
        % Determine the Score, Benefits and Costs for Expansion Candidates
        [Candidate(n).Score,Candidate(n).UserBenefits,Candidate(n).OperCosts,Candidate(n).Ridership]= CalcScore(Candidate(n),CurCosts,d_ij,MinTravelDist,VMode,VAlt,Alpha,VOT,LBeta);
        
%         if numel(Candidate)==1 %Only a single candidate? %Is this needed?
%             [Candidate(n).Score,Candidate(n).UserBenefits,Candidate(n).OperCosts]=CapacityScore(Candidate(n),Links,Alpha,VOT);
%             Candidate(n).Costs=CurCosts;
%             Candidate(n).paths=CurPath;
%         elseif Stop==1 % If we should stop due to earlier stop?
%             break
%         elseif n==numel(Candidate) %Capacity Candidate is different!? (Score = dLoad*Users?)
%             [Candidate(n).Score,Candidate(n).UserBenefits,Candidate(n).OperCosts]=CapacityScore(Candidate(n),Links,Alpha,VOT);
%             Candidate(n).Ridership=Candidate(n-1).Ridership; %Hack to ensure ridership isnt lost
%             Candidate(n).Costs=CurCosts;
%             Candidate(n).paths=CurPath;
        %else %It is a link creation and thus can be scored based on dTTT
%             [Candidate(n).Score,Candidate(n).UserBenefits,Candidate(n).OperCosts,Candidate(n).Ridership]= CalcScore(Candidate(n),CurCosts,d_ij,MinTravelDist,VMode,VAlt,Alpha,VOT,LBeta);
%         end
        %Then lets find the best Candidate!
        if Candidate(n).Score > 0 && Candidate(n).Score > BestScore && Stop==0
            BestScore=max(BestScore,Candidate(n).Score);
            Sel_Can=Candidate(n);
%             if n==numel(Candidate)
%                 CapacityTrue=1;
%             end
        end
    end
    
    %Check if the Capacity Scores are better then the Expansion Scores
    for n=1:1:numel(Candidate2)
        % Determine Benefits, Costs and Score for Capacity Increase
        [Candidate2(b).Benefits,Candidate2(b).Costs,Candidate2(b).Score]=calcCapScore(Candidate2(b),Links,Alpha,VOT);
        % Check if these are better then the Expansion Scores
        if Candidate2(n).Score > BestScore && Candidate2(n).Score > 0 && Stop == 0
            Sel_Can.StartNode = Candidate2(n).StartNode;
            Sel_Can.EndNode = Candidate2(n).EndNode;
            Sel_Can.NewLinkLength = Candidate2(n).NewLinkLength;
            Sel_Can.Links = Candidate2(n).Links;
            Sel_Can.NetMat = NetMat;
            Sel_Can.Costs = CurCosts;
            Sel_Can.Score = Candidate2(n).Score;
            Sel_Can.paths = CurPath;
            Sel_Can.UserBenefits = Candidate2(n).Benefits;
            Sel_Can.OperCost = Candidate2(n).Costs;
            Sel_Can.Ridership = Sel_Can.Ridership; %Maintain Ridership 

            BestScore = max(BestScore,Candidate2(n).Score);
            CapacityTrue=1;
        end
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

        %Calulate the Actual Share of Realised Demand:
        %Calculate Traveltimes = (Distance / Speed)  [hours] 
        TT_Alt    = (MinTravelDist ./ VAlt);       %in HOURS
        TT_PT_Cur = (CurCosts ./ VMode);        %in HOURS
        % Calculate the Modal Split for both scenarios [%,%]
        [AltShare_Cur,PTShare_Cur]=logitUtility(LBeta,TT_Alt,TT_PT_Cur);
        %Calculate TripCounts (Multiply Respective Share with the ODMatrix) [Persons]
        Users_Alt_Cur = AltShare_Cur .* d_ij;
        Users_PT_Cur  = PTShare_Cur  .* d_ij;
        History(ii).Links=Links;
        History(ii).UserBenefits=Sel_Can.UserBenefits;
        History(ii).Ridership=Sel_Can.Ridership;
        History(ii).Denied=sum([Sel_Can.Links.Usage]) - sum([Sel_Can.Links.Capacity]);
        [History(ii).Beta,History(ii).Gamma,History(ii).Diameter,History(ii).APL,History(ii).AvgDeg,History(ii).AvgBc,History(ii).sdDeg,History(ii).sdBc,History(ii).TLL]=calcIndicators(NetAdjMat,AdjMat,NetMat,CurCosts,Nodes,Links);
%         set(gca,'NextPlot','replacechildren') ;
%         DrawNetwork(Nodes,Links);
%         drawnow;
%         set(gca, 'Visible', 'off')
%         F(ii)=getframe(f1);
        %writeVideo(v, frame);
        if CapacityTrue==0
            Links=LinkLoad(Links,Users_PT_Cur,Sel_Can.paths); %New Usage Determination Test
        end
    History(ii).AverageLinkLoad=mean([Links.Usage]);
    end
    disp(["iteration:" num2str(ii)])
    %advance a timestep and continue the loop.
    % clear Sel_Can;
    ii=ii+1;
    toc
end
%close(v);
% M(ii-1)= struct('cdata',[],'colormap',[]);
% for a=1:1:(ii-1)
%     M(a)=F(a);
% end
%     
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

% ---------------------------
% -- Visualise the network --
% ---------------------------
VisualiseNetwork(History,Nodes,Links,CapValue,MaxCapacity,R,phi,S);
toc 

%% Save Video
% v = VideoWriter('Test.avi');
% v.FrameRate=4;
% open(v);
% writeVideo(v,M);
% close(v)
