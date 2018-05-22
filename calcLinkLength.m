% CALCLINKLENGTH Calculate Link Length based on Node and Link Libraries
% Filename: calcLinkLength.m
%
% Description:
%     Given a list of Nodes(r,phi) and a Link (Start,End) determine length
%     of each link and store this in the Links Library under [Length]
% Author:
%     Alex Vermeulen
%     zxbiohazardzx@gmail.com
% Inputs:
%     [Nodes] Structure containing all Node Locations [r,phi]
%     [Links] Structure containing Link for evaluation [Start,End,Length]
% Outputs:
%     [Length] the length for the given inputs
% Usage:
%     outputLength = calcLinkLength(Nodes,Links)
%
function outputLength = calcLinkLength(Nodes,Links)
% Determine the type (Ring/Radial) using difference in r coordinate:
DiffR=Nodes(Links.EndNode).r - Nodes(Links.StartNode).r;
%Conditional Split to quickly determine link length
if DiffR == 0 %This is a RINGELEMENT (Same radius, thus on a ring)
    if Links.StartNode+1 == Links.EndNode %Check -> NOT Closing segment!
        %For Most Ring Elements--> Length = d_phi*r
        DiffPhi=Nodes(Links.EndNode).phi - Nodes(Links.StartNode).phi;
        outputLength=abs(DiffPhi*Nodes(Links.EndNode).r);
    else % If it is a Closing Segment THEN normalise endpoint to 2*pi NOT 0
        if Nodes(Links.StartNode).phi==0 % If StartNode is 0 THEN
            DiffPhi=Nodes(Links.EndNode).phi - 2*pi; %EndNode Normalisation
        else % Startnode Normalisation
            DiffPhi=Nodes(Links.StartNode).phi - 2*pi;
        end
        %Length = d_phi*r (Same as in the Other Ring Segments)
        outputLength=abs(DiffPhi*Nodes(Links.EndNode).r);
    end
else %it is a radial (r1=/r2)
    outputLength=DiffR; %Length = Difference in Radial Coordinate
end

