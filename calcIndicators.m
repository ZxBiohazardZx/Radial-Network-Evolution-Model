% calcLinkLength Calculate Link Length for given Nodes/Links
% Date of file creation: 27 December 2017
% Date of last edit: 4 January 2018
% Creator: Alex Vermeulen

% o Average shortest path length (implemented in History)
% o Weighted average shortest path length (not implemented)
% o Gamma-index of largest component
% o Weighted size of largest component
% o Coefficient of variation in node degrees
% o Average betweenness centrality
% o Coefficient of variation of betweenness centrality
function [Beta,Gamma,Diameter,APL,AvgDeg,AvgBc,sdDeg,sdBc,TLL,Ringness,Detour] = calcIndicators(NetAdjMat,AdjMat,NetMat,CurCosts,Nodes,Links,MinTravelDist)
%function Output = calcIndicators(NetAdjMat,AdjMat,NetMat,CurCosts,Nodes,Links)
%Build a Structure for all output Elements
%Output=struct('Beta',[],'Gamma',[],'Diameter',[],'APL',[],'AvgDeg',[],'AvgBc',[],'sdDeg',[],'sdBc',[],'TLL',[]);
% - Determine Each Indicator using inputs:
Beta=numel(Links) / numel(Nodes); % Edges / Nodes
Gamma=nnz(AdjMat)/nnz(NetAdjMat); % Edges / Max Possible Edges 

%Semi-Normalised (remove infinity) for these indicators
costs=CurCosts;%Temp change the value
APL=mean(costs(~isinf(costs)));
costs(~isfinite(costs))=0; %Normalise the costs
Diameter=max(max(costs)); %Compute the diameter (Longest shortest path)
TLL=sum([Links(:).Length]);       % Total Link Length (System Length)
sumring=0;
for n=1:1:numel(Links)
    if Links(n).Length~=5 %Magic check for RADIAL = 5
       sumring=sumring+Links(n).Length;
    end
end
Ringness = sumring/TLL;
Detour = CurCosts ./ MinTravelDist;
% Distribution Indicators at Node-Level (Degree, Betweenness centrality)
[AvgDeg,AvgBc,sdDeg,sdBc]=CalcNodeIndicators(NetMat,Nodes);

%Assumes UNDIRECTED GRAPH
function [avgNodeDeg,avgBc,sdDeg,sdBc] = CalcNodeIndicators(NetMat,Nodes)
G=graph(NetMat);
n=numel(Nodes);
NodeDegree=degree(G);
avgNodeDeg=mean(NodeDegree);    %Average Degree
sdDeg=std(NodeDegree);          %Standard deviation
%Betweenness Centrality (Weighted, Average)
wbc = centrality(G,'betweenness','Cost',G.Edges.Weight);
wNBc = 2*wbc./((n-2)*(n-1));    %Normalise by nodes (formula)
avgBc = mean(wNBc);             %Average as indicator
sdBc=std(wNBc);                 % Standard deviation



