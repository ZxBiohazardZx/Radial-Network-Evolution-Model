function [EdgeList] = LinkLoad(EdgeList,Demand,Paths)
% LinkLoad Determination Algorithm
% Filename: LinkLoad.m
% Description: Given EdgeList, Demand Matrix and Path Array this algorithm will determine the
% load of the given link by assigning the Demand from I to J along its
% path elements
%
% Author:
%       Alex Vermeulen
%       zxbiohazardzx@gmail.com
% Date: 04/04/2018
% Release: 1.0
%
% Inputs:
%     [EdgeList] 
%         A list of edges with at least the following structure elements:
%         <StartNode,EndNode,Load>
%     [Demand]
%         Origin-Destination Demand Matrix for the given network scenario.
%         This effectively is the assigned demand for the network.
%     [Paths]
%         [Paths] is an LxM cell array containing the shortest path arrays
%         for each origin destination pair

%Clear EdgeList usage for the current iteration so we dont sum for all iterations!;
for h=1:1:numel(EdgeList)
    EdgeList(h).Usage=0;
end
%Start Main loop: For each path element DO:
for i=1:1:numel(Paths)
    % Explode the path into subpath / Array Element
    C=Paths{i};
    % If there is a path (Not a SELF connectio or NAN) 
    if numel(C) >= 2
        for j=1:1:numel(C)-1 %For each Path Element
            Node1 = C(j); %Determine First Node
            Node2 = C(j+1); %Determine Next Node
            if Node2 < Node1 %Inverted Direction from Node 2 to Node 1 find other edge!
                [~,k]=find([EdgeList.StartNode]==Node2 & [EdgeList.EndNode]==Node1);   %Link Index of Edge
                
            else % Normal Direction from Node1 to Node2
                [~,k]=find([EdgeList.StartNode]==Node1 & [EdgeList.EndNode]==Node2);   %Link Index of Edge
            end
            for m=1:1:numel(k)
                if isempty(EdgeList(k).Usage)
                    EdgeList(k).Usage = Demand(i);
                else
                    EdgeList(k).Usage = EdgeList(k).Usage + Demand(i);
                end
                
            end
        end
    end
end
