% GENERATECANDIDATES Determine potential investment Candidates 
% Filename: GenerateCandidates.m
%
% Description:
%     Given the Max Planar Graph Adjacency Matrix and the Current Adjacency
%     Matrix Determine the potential investment Candidates
% Author:
%     Alex Vermeulen
%     zxbiohazardzx@gmail.com
% Inputs:
%     [NetAdjMat] NxN Adjacency Matrix of the Max Planar Graph
%     [AdjMat] NxN Adjacency Matrix of the current network state
% Outputs:
%     [CandidateOut] Investment Candidate Structure
% Usage:
%     CandidateOut = GenerateCandidates(NetAdjMat,AdjMat)
%

function CandidateOut = GenerateCandidates(NetAdjMat,AdjMat)
%Candidate Structure Definition
CandidateOut=struct('StartNode',[],'EndNode',[],'NewLinkLength',[],'Links',[],'NetMat',[],'Costs',[],'Score',[]);

%Determine Potential Investment Candidate Matrix
CandidateMatrix = NetAdjMat - AdjMat;

% Find a StartNode for Candidates by determining the indeces of non-zero AdjMat Elements
[StartNode,~]=find(AdjMat);
% Ensure we do not have duplicates within this set as (i,j = j,i)
StartNode=unique(StartNode);

% Find the Candidates, Output is INDEX,EndNode (Index needs replacement)
[IndexI,EndNodeJ]=find(CandidateMatrix(StartNode,:));
IndexI=StartNode(IndexI); %Replace Index with actual StartNode

for a=1:1:numel(IndexI)
        CandidateOut(a).StartNode=IndexI(a); % StartNode from IndexI
        CandidateOut(a).EndNode=EndNodeJ(a); % EndNode from Candidates
end

% Remove any Candidates that are "Wrong Way" (unidirectional Graph)
a=1;
while a < numel(CandidateOut)
  if CandidateOut(a).StartNode > CandidateOut(a).EndNode
     CandidateOut(a) = [];
     a=a-1;
  end
  a=a+1;
end




