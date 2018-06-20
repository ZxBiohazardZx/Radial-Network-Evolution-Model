% GENERATECANDIDATES Determine potential investment Candidates 
% Filename: genExpansionCandidates.m
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
% SubFunctions:
%     calcCanProp(CandidateOut,Nodes,Links,CapValue)
% Usage:
%     CandidateOut = GenerateCandidates(NetAdjMat,AdjMat)
%

function CandidateOut = genExpansionCandidates(NetAdjMat,AdjMat,Nodes,Links,CapValue)
%Candidate Structure Definition
CandidateOut=struct('StartNode',[],'EndNode',[],'NewLinkLength',[],'Links',[],'NetMat',[],'Costs',[],'Score',[]);

%Determine Potential Investment Candidate Matrix
CandidateMatrix = NetAdjMat - AdjMat;

% Unidirectional -> ONLY NEED UPPER TRIANGLE: 
CandidateMatrix = triu(CandidateMatrix);

% Find a StartNode for Candidates by determining the indeces of non-zero AdjMat Elements
[StartI,StartJ]=find(triu(AdjMat));
StartNode = [StartI StartJ];
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
    %Should we just invert these pairs!? or Remove them?
  if CandidateOut(a).StartNode > CandidateOut(a).EndNode
%      Temp=CandidateOut(a).EndNode;
%      CandidateOut(a).EndNode = CandidateOut(a).StartNode;
%      CandidateOut(a).StartNode = Temp;
     CandidateOut(a)=[]; %Remove it!
     a=a-1;
  end
  a=a+1;
end

CandidateOut = calcCanProp(CandidateOut,Nodes,Links,CapValue);




