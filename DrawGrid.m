%--------------------------------------------------------------------------
%--                   DrawGrid EXTENDS MAINFILE                          -- 
%--------------------------------------------------------------------------
% - INPUT: Radius R, Number of Rings S
% - OUTPUT: Figure with reference Grid
% - METHOD:
%   Draws the reference grid for the polar network in black dashes.
%   Requires global variables passed down
%--------------------------------------------------------------------------

function DrawGrid(R,phi_rad,S)
% r is a linspace to allow for plotting the intermediate rings (S+1)
% phi is angleplot from 0 to 2PI using 0.01 intervals
hold on % Hold the figure to plot multiple things in 1 figure
axis equal % Equal Axis ensures polar plot remains scaled
r=linspace(0,R,S+1); 
phi_grid=0:0.1:2*pi; % Angle w from 0 to 2PI (full circle) in steps of 0.01
offset_angle=0:phi_rad:2*pi-phi_rad; %sector definition
for n=1:length(offset_angle)% - 1st Loop to plot the Grid-Radials
    plot(real([0 R]*exp(1i*offset_angle(n))),imag([0 R]*exp(1i*offset_angle(n))),'Color',[0.5 0.5 0.5],'LineStyle','--')
end
for n=2:length(r)% - 2nd Loop to plot the Grid-Rings
    plot(real(r(n)*exp(1i*phi_grid)),imag(r(n)*exp(1i*phi_grid)),'Color',[0.5 0.5 0.5],'LineStyle','--')
end

