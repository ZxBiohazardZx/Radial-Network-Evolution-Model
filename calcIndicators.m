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
function [Beta,Gamma,Diameter,APL,AvgDeg,AvgBc,sdDeg,sdBc,TLL] = calcIndicators(NetAdjMat,AdjMat,NetMat,CurCosts,Nodes,Links)
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
% Distribution Indicators at Node-Level (Degree, Betweenness centrality)
[AvgDeg,AvgBc,sdDeg,sdBc]=CalcNodeIndicators(NetMat,Nodes);
TLL=sum([Links(:).Length]);       % Total Link Length (System Length)
% Ridership - Total Passenger KM?
% Farebox Recovery Ratio? (Ticket * Pax - Operational costs)

%NOTES: 
% Beta, Gamma, TLL, & Degree follow same pattern (by definition)
% sdDeg,AvgBc,sdBc are interesting

%Output.AvgNodeCentral=Avg_NodeCentral(AdjMat);

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


%Assumes UNDIRECTED GRAPH
% function avgNodeCen = Avg_NodeCentral(AdjMat)
% G=graph(AdjMat);
% NodeDegree=degree(G);
% avgNodeCen=mean(NodeDegree);

% Pi Index. The relationship between the total length of the graph L(G) and
% the distance along its diameter D(d). It is labeled as Pi because of its
% similarity with the real Pi value, which is expressing the ratio between
% the circumference and the diameter of a circle. A high index shows a
% developed network. It is a measure of distance per units of diameter and
% an indicator of the shape of a network.
% Pi = L(G) / D(d)



