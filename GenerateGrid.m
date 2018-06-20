function Nodes = GenerateGrid(R,phi,S,Pop_Dist)
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


%---------------------------
%-- Population Definition -- 
%---------------------------
for a=1:1:numel(Nodes)
    switch Pop_Dist
        case 1 % Uniform Distribution
            Nodes(a).pop = 82500;                           % Uniform Population   ~ 8 mill
        case 2 % Linear Distribution
            Nodes(a).pop = 165000 - (Nodes(a).r / R)*145000; % Linear Decay Function ~ 8.340 mill
        case 3 % Exponential Distribution
            Nodes(a).pop = 275000*exp(-Nodes(a).r/15);   %Exponential Decay Function  ~ 8.311 mill
        otherwise
            warning('No valid population provided');
    end
if a==1
     Nodes(a).pop=2*Nodes(a).pop;
 end
end
