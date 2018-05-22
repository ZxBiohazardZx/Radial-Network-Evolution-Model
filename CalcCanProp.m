function CanIn = CalcCanProp(CanIn,Nodes,Links,MinTravelDist,CapValue)
% - For each CandidatePair:
%    - Determine the Link Length
%    - TempBuild the Candidate Link (FunctionCall)
%    - Determine NetworkMatrix  (FunctionCall)
%    - Call Dijksta for new Shortest Path Lengths (FunctionCall)
%    - Accessibility = CurrentDistance / MinTravelDist
for n=1:1:numel(CanIn)
    %Build the Candidate Link and save as Links in the Candidate
    CanIn(n).Links=BuildLink(CanIn(n).StartNode,CanIn(n).EndNode,Nodes,Links,CapValue);
    %Calculate New Link Length
    TempLink.StartNode=CanIn(n).StartNode;
    TempLink.EndNode=CanIn(n).EndNode;
    CanIn(n).NewLinkLength=calcLinkLength(Nodes,TempLink);
    %Determine NetworkMatrix
    CanIn(n).NetMat=NetworkMatrix(Nodes,CanIn(n).Links);
    % Call Dijkstra to determine Path Lengths between Nodes
    [CanIn(n).Costs,CanIn(n).paths]=dijkstra(logical(CanIn(n).NetMat),CanIn(n).NetMat);
end

