function CandidateOut = AddCapacityCandidate(CandidateIn,Links,Nodes,CapValue,MaxCapacity)
% Candidate Generation (Formula later)
% Determine all Candidates that are possible given current Adj matrix
% compared against the full planar graph
%initialisation
CandidateOut=CandidateIn;
MaxDenied = 0; 
Index=0;

% In order to effectively assess a capacity candidate we pre-select based
% on denied boardings: DemandUse - Capacity
for a=1:1:numel(Links)
    % Determine the Unused Potential
    Denied = Links(a).Usage - Links(a).Capacity;
   % Determine if this is the best candidate for investment: 
   % If it has not yet reached maximum Capacity & Denied Passengers are max
    if Links(a).Capacity < MaxCapacity && Denied > MaxDenied
        MaxDenied = Denied; % Set the new MaxDenied Value to current Value
        Sel_Link = Links(a);% Save the Current Link as Selected Link
        Index = a;          % Update the Index for searching?
    end
end

%Now we have the Selected Link -> Build the Candidate Structure Output:
if Index==0 % No Suitable Capacity Candidate was found -> Return Empty/DEBUG
    b=numel(CandidateOut);
    CandidateOut(b+1).StartNode=-1; % DEBUGNODE = -1
    CandidateOut(b+1).EndNode=-1; % DEBUGNODE = -1
    CandidateOut(b+1).NewLinkLength=-1; % DEBUGNODE = -1
    CandidateOut(b+1).Links=[]; %DEBUG: EMPTY
    CandidateOut(b+1).NetMat=[]; %DEBUG: EMPTY
    
else % A suitable Capacity Expansion has been found -> Add to OutputStructure
    b=numel(CandidateOut); % Determine Structure Length
    CandidateOut(b+1).StartNode=Sel_Link.StartNode; % StartNode from Selected Link
    CandidateOut(b+1).EndNode=Sel_Link.EndNode; % EndNode from Selected Link
    CandidateOut(b+1).NewLinkLength=calcLinkLength(Nodes,Sel_Link); % Determine Link Length
    CandidateOut(b+1).Links=Links; % Add Link Library From Old Library
    CandidateOut(b+1).Links(Index).Capacity=CandidateOut(b+1).Links(Index).Capacity+CapValue; % Update Capacity for Selected Candidate only
    CandidateOut(b+1).NetMat=NetworkMatrix(Nodes,CandidateOut(b+1).Links); % Add the Network Matrix (unsure why?)
end











