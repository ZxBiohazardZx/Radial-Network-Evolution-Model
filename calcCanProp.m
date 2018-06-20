% CALCCANPROP Determine Candidate Properties for evaluation
% Filename: calcCanProp.m
%
% Description:
%     For each Candidate determine properties that can be used for scoring
%     and evaluation purposes in later functions. This function has
%     dependancies in subfunctions to compute its components.
% Author:
%     Alex Vermeulen
%     zxbiohazardzx@gmail.com
% Inputs:
%     [CanIn] Input Candidates to determine properties 
%     [Nodes] Structure containing all Node Locations [r,phi]
%     [Links] Structure containing Link for evaluation [Start,End,Length]
%     [CapValue] Capacity Value Increment
% SubFunctions:
%     BuildLink(Candidate,StartNode,EndNode,Nodes,Links,CapValue)
%     calcLinkLength(Nodes,ConstructedLink)
%     NetworkMatrix(Nodes,Links)
%     dijkstra(AdjacencyMatrix,NetworkMatrix)
% Outputs:
%     [CanIn] Updated Candidates including properties for evaluation
% Usage:
%       CanIn = calcCanProp(CanIn,Nodes,Links,CapValue);
%
function CanIn = calcCanProp(CanIn,Nodes,Links,CapValue)
% For each input Candidate compute the requested properties
for n=1:1:numel(CanIn)
    TempLink.StartNode=CanIn(n).StartNode;
    TempLink.EndNode=CanIn(n).EndNode;
    if TempLink.StartNode < TempLink.EndNode
        %Build the Candidate Link and save as Links in the Candidate
        CanIn(n).Links=BuildLink(CanIn(n).StartNode,CanIn(n).EndNode,Nodes,Links,CapValue);
        %Calculate New Link Length using a TempLink
        CanIn(n).NewLinkLength=calcLinkLength(Nodes,TempLink);
        %Determine the new NetworkMatrix for this candidate
        CanIn(n).NetMat=NetworkMatrix(Nodes,CanIn(n).Links);
        % Call Dijkstra to determine Path Lengths between Nodes
        [CanIn(n).Costs,CanIn(n).paths]=dijkstra(logical(CanIn(n).NetMat),CanIn(n).NetMat);
    end
end

