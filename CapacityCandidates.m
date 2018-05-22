function CandidateOut = CapacityCandidates(Links,CapValue,MaxCapacity)
% Initialisation Phase

% A capactiy Candidate Increases the Capacity of a link. The size of the
% struct therefore is equal to the number of links
CandidateOut=struct('StartNode',[],'EndNode',[],'NewLinkLength',[],'Denied',[],'Links',[],'Benefits',[],'Costs',[],'Score',[]);

for a=1:1:numel(Links)
    CandidateOut(a).StartNode = Links(a).StartNode;
    CandidateOut(a).EndNode = Links(a).EndNode;
    CandidateOut(a).NewLinkLength = Links(a).Length;
    CandidateOut(a).Denied = Links(a).Usage - Links(a).Capacity;
    CandidateOut(a).Links=Links;
    if Links(a).Capacity < MaxCapacity
        CandidateOut(a).Links(a).Capacity=Links(a).Capacity+CapValue;
    end
end



