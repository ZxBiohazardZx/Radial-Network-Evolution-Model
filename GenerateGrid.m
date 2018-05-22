function Nodes = GenerateGrid(R,phi,S)
% --------------------------------------
% -- Define Nodes / connection points -- 
% --------------------------------------
%Define Struct & Origin (node 1):
Nodes=struct('r',0,'phi',0);
%derrived variables to make typing smaller
num_seg=(2*pi)/phi;          %number of Segments

% -------------------------------------
% -- Loop to generate the gridpoints --
% -------------------------------------
for n=1:1:(S*num_seg)+1
    % Origin Node is always node 1
    if n==1
        Nodes(n).r=0;
        Nodes(n).phi=0;
    else
        %The rest of the Nodes can be found on rings:
%         if mod(n-1,num_seg)==0 %if the modulo is 0, fix the index!
%             Nodes(n).r=ceil(n/num_seg)*(R/S);
%             Nodes(n).phi=2*pi-phi;
%         else %use modulo to determine the r,phi values
            Nodes(n).r=ceil((n-1)/num_seg)*(R/S);
        	Nodes(n).phi=phi*(mod((n-2),num_seg));
%         end
    end
end

