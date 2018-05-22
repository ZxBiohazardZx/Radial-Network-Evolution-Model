function LinksOut = MaxPlanarGraph(R,phi_rad,S,NodesIN)
% r is a linspace to allow for plotting the intermediate rings (S+1)
% phi is angleplot from 0 to 2PI using 0.01 intervals
% -----------------------------------------------
% -- Define Max Planar Graph for given R,phi,S --
% -----------------------------------------------
%Define Struct & Origin (node 1):
LinksOut=struct('StartNode',0,'EndNode',0);
%derrived variables to make typing smaller
num_seg=(2*pi)/phi_rad;          %number of Segments
LinksOut(1)=[];
% -------------------------------------
% -- Loop to generate the Links --
% -------------------------------------

for n=1:1:numel(NodesIN) % For each Node:
    %Determine the relation with the other nodes
    for i=1:1:numel(NodesIN)
        DiffR = NodesIN(n).r - NodesIN(i).r;
        DiffPhi=NodesIN(n).phi/phi_rad - NodesIN(i).phi/phi_rad;
        if DiffR==0 && abs(DiffPhi)==num_seg-1 && mod(i,num_seg)==1
            %Ring Closing Segment!
            p=length(LinksOut);
            LinksOut(p+1).StartNode=i;
            LinksOut(p+1).EndNode=n;
            LinksOut(p+1).Length=calcLinkLength(NodesIN,LinksOut(p+1));
            LinksOut(p+1).Info='ClosingSegment';
        elseif DiffR == 0 && abs(DiffPhi) <= 1 && n<i
            %This is a ring candidate and thus needs to be added
            p=length(LinksOut);
            LinksOut(p+1).StartNode=n;
            LinksOut(p+1).EndNode=i;
            LinksOut(p+1).Length=calcLinkLength(NodesIN,LinksOut(p+1));
            LinksOut(p+1).Info='Ring n NOT i';        
        elseif abs(DiffR) <= R/S && n<i && i <= num_seg+1 && n==1
            p=length(LinksOut);
            LinksOut(p+1).StartNode=n;
            LinksOut(p+1).EndNode=i;
            LinksOut(p+1).Length=calcLinkLength(NodesIN,LinksOut(p+1));
            LinksOut(p+1).Info='StartRadial';
        else
            if DiffPhi == 0 && abs(DiffR) <= R/S && n<i
                %This is a radial candidate and thus needs to be added
                p=length(LinksOut);
                LinksOut(p+1).StartNode=n;
                LinksOut(p+1).EndNode=i;
                LinksOut(p+1).Length=calcLinkLength(NodesIN,LinksOut(p+1));
                LinksOut(p+1).Info='OtherRadial';
           end
        end
    end
end