% -- Grid Definition
R=40;        %radius (Km)
phi_deg=30;  %Radial Offset Angle (DEGREES)
S=8;         %Number ofRings (spaced R/S)  
% -- Population / Demand Definition
%Population = 350; % Population PER NODE
% -- Derived Variables -- 
%phi=deg2rad(phi_deg); %angle phi in radians

figure;
DrawGrid(R,phi,S);
for n=1:1:numel(Nodes) % For each Node:
    %find the coordinates we need
    xplot(n)= Nodes(n).r*cos(Nodes(n).phi);
    yplot(n)= Nodes(n).r*sin(Nodes(n).phi);
    zplot(n)= Nodes(n).pop;

%    [X,Y]=meshgrid(xplot,yplot);
%    zplot2(n)= 0*X + 0*Y + Nodes(n).pop;
    pointsize = 100;
    scatter(xplot, yplot, pointsize, zplot,'filled');
end

%surf(X,Y,zplot2)

