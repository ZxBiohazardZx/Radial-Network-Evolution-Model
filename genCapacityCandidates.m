% CAPACITYCANDIDATES Determine Investment Candidates by adding Capacity
% Filename: genCapacityCandidates.m
%
% Description:
%     Given a list of all Links, Define Capacity Candidates by increasing
%     capacity for a given link. A capactiy Candidate Increases the
%     Capacity of a link. The size of the struct therefore is equal to the
%     number of links
% Author:
%     Alex Vermeulen
%     zxbiohazardzx@gmail.com
% Inputs:
%     [Links]  List of all constructed Links with their respective Capacity Values
%     [CapValue] Capacity Value Increment
%     [MaxCapacity] Maximum Capacity for the mode Parameter
% Outputs:
%     [CandidateOut] Structure with Candidates for Capacity Increase
% Usage:
%       CandidateOut = CapacityCandidates(Links,CapValue,MaxCapacity);
%
function CandidateOut = genCapacityCandidates(Links,CapValue,MaxCapacity)
% Initialisation Phase
CandidateOut=struct('StartNode',[],'EndNode',[],'NewLinkLength',[],'Denied',[],'Links',[],'Benefits',[],'Costs',[],'Score',[]);

% For all existing links - Add a candidate that is the same link, but with
% more capacity.
for a=1:1:numel(Links)
    CandidateOut(a).StartNode = Links(a).StartNode;
    CandidateOut(a).EndNode = Links(a).EndNode;
    CandidateOut(a).NewLinkLength = Links(a).Length;
    CandidateOut(a).Denied = Links(a).Usage - Links(a).Capacity;
    % Extra Test
    CandidateOut(a).DeniedAfter = Links(a).Usage - (Links(a).Capacity+CapValue);
    if CandidateOut(a).DeniedAfter < 0
        CandidateOut(a).DeniedAfter = 0;
    end
    CandidateOut(a).CapacityBefore = Links(a).Capacity;
    % End Extra Test
    CandidateOut(a).Links=Links;
    if Links(a).Capacity < MaxCapacity
        CandidateOut(a).Links(a).Capacity=Links(a).Capacity+CapValue;
    end
    CandidateOut(a).LinkUsage=CandidateOut(a).Links(a).Usage;
    
end

b=1;
while b < numel(CandidateOut)
    %Remove Candidates that are already Maxed out
    if CandidateOut(b).CapacityBefore == MaxCapacity
        CandidateOut(b)=[];
        b=b-1;
    end
    b=b+1;
end





