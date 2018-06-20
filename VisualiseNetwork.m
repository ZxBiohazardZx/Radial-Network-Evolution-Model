function VisualiseNetwork(History,Nodes,Links,CapValue,MaxCapacity,R,phi,S)
set(groot,'defaultLineLineWidth',1.5)
x=1:1:numel(History);
y1=[History.Score];
y2=[History.Beta];y3=[History.Gamma]; 
y4=[History.Diameter]; y5=[History.APL];
%y6=[History.AverageLinkLoad];
y6=[History.AvgLoadRatio];
y7=[History.TLL];
y8=[History.Ridership];
y9=[History.Denied];
y10=[History.AvgBc];
y11=[History.sdBc];
y12=[History.TTT];
%y13=[History.AScore];
y14=[History.Ringness];

% Create a Figure to plot stuff in, 9 Graphs Total
figure('Name','Network Indicators','NumberTitle','off');
% First Row: 3 Graphs
    % 1st Subgraph: KPI - Score of the Alternative
        subplot(3,3,1)
        plot(x,y1)
        title('KPI - Score')
        ylabel('Score')
    % 2st Subgraph: KPI - Beta & Gamma Indices 
        subplot(3,3,2)
        plot(x,y2,x,y3,x,y14)
        title('KPI - Beta & Gamma')
        legend('Beta','Gamma','Ringness')
    % 3rd Subgraph: KPI - Diameter (Longest Shortest Path) & Average Shortest Path Length     
        subplot(3,3,3)
        plot(x,y4,x,y5)
        title('KPI - Diameter & APL')
        legend('Diameter','APL')

% Second Row: 3 Graphs
    % 4th Subgraph: Performance - Average Link Load [Demand/Capacity]
        subplot(3,3,4)
        plot(x,y6)
        title('Perf - Average Link Load')
        ylabel('AvgLoadRatio')
    % 5th Subgraph: Performance - Total System Length [Km]
        subplot(3,3,5)
        plot(x,y7)
        title('System Length [Km]')
    % 6th Subgraph: Performance - Total Travel Time
        subplot(3,3,6)
        plot(x,y12)
        title('Total Travel Time')
        

% Third Row: 3 Graphs

% 7th Subgraph: Performance - Induced Demand [Ridership]
subplot(3,3,7)
plot(x,y8)
title('Potential PT Ridership')
% 8th Subgraph: Performance - Remaining Potential 
subplot(3,3,8)
plot(x,y9)
title('Unutilised Demand')
% 9th Subgraph: KPI - Average Node Degree & Deviation
subplot(3,3,9)
plot(x,y10,x,y11);
title('Node Betw.Centrality - Average & Std.Dev')
legend('Avg','StdDev')

set(groot,'defaultLineLineWidth','remove')
%New Figure for Network Visualisation
figure('Name','Network Visualisation','NumberTitle','off');
ax = gca;
ax.Visible = 'off';
DrawGrid(R,phi,S);
DrawNetwork(Nodes,Links,CapValue,MaxCapacity)
title('Network Visualisation')

% subplot(3,3,9)
% plot(x,y10);
% title('Sum PT Users')
