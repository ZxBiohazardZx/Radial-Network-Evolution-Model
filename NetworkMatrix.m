% NetworkMatrix 
% Description: Given Nodes and Links,this function computes the Network
% Matrix (LinkLengths) and corresponding Adjacency Matrix
%
% Author: Alex Vermeulen
% Inputs: 
%  Nodes is a list of all Node coordinates (r,phi)
%  Links is a list of links between nodesets <N1(r1,phi1),N2(r2,phi2)>
% Outputs:
%     [NetMat] is an NodeIxNodeJ matrix of LinkLength values if and only if a
%     link connects the nodes(i,j)
%     [AdjMat] is an NodeIxNodeJ Logical Matrix with a 1 if and only if a
%     link connects the nodes(i,j)
% Usage:
%     [NetMat,AdjMat] = NetworkMatrix(Nodes,Links)
function [NetMat,AdjMat] = NetworkMatrix(Nodes,Links)
    NetMat=zeros(numel(Nodes));
    % Define Links and Distances
        for n=1:1:numel(Links)
            NetMat(Links(n).StartNode,Links(n).EndNode)=Links(n).Length;   
        end
    % Make it Symmetrical
    NetMat=NetMat'+NetMat;
    AdjMat=logical(NetMat);
end