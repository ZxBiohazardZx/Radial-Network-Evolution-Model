function [hasEdge,nLinks] = routesThroughLink(Link,paths)
edge = [Link.StartNode Link.EndNode];
invEdge = fliplr(edge); %Check for both directions as the path could occur in reverse for SP
hasEdge = cellfun(@(x)contains(sprintf('%d ',x),sprintf('%d ',edge)),paths) | cellfun(@(x)contains(sprintf('%d ',x),sprintf('%d ',invEdge)),paths);
nLinks = nnz(hasEdge);
%Modify to compute actual use, not just ammount of shortest paths through
%it (betweenness centrality now?)
% TODO: Check if we can only consider upper triangular array? (Saves alot
% of computations!) 

%Check: Is it faster to loop over paths index and then assign demand?
% AKA: For Each Cell -> Explode -> Assign Load to Sub-Paths

