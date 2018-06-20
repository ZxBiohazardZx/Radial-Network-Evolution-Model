function CompareGraphs(BRT_History,LRT_History,Metro_History)
% Set X-Asis for plotting
x1=1:1:numel(BRT_History);x2=1:1:numel(LRT_History);x3=1:1:numel(Metro_History);
% Score (evolution) Comparison
y1=[BRT_History.Score];y2=[LRT_History.Score];y3=[Metro_History.Score];
%Accumulated Score Comparison
y4=[BRT_History.AScore];y5=[LRT_History.AScore];y6=[Metro_History.AScore];
% Beta, Gamma Comparison
y7=[BRT_History.Beta];y8=[LRT_History.Beta];y9=[Metro_History.Beta];
y10=[BRT_History.Gamma];y11=[LRT_History.Gamma];y12=[Metro_History.Gamma];
% Diameter & APL Comparison
y13=[BRT_History.Diameter];y14=[LRT_History.Diameter];y15=[Metro_History.Diameter];
y16=[BRT_History.APL];y17=[LRT_History.APL];y18=[Metro_History.APL];
% AverageLinkLoad Comparison
y19=[BRT_History.AverageLinkLoad];y20=[LRT_History.AverageLinkLoad];y21=[Metro_History.AverageLinkLoad];
%Ridership / CP Comparison
y22=[BRT_History.Ridership];y23=[LRT_History.Ridership];y24=[Metro_History.Ridership];
% Betweenness Centrality (EDGE?)
y25=[BRT_History.AvgBc];y26=[LRT_History.AvgBc];y27=[Metro_History.AvgBc];
% System Length Comparison
y28=[BRT_History.TLL];y29=[LRT_History.TLL];y30=[Metro_History.TLL];
% Denied Ridership
y31=[BRT_History.Denied];y32=[LRT_History.Denied];y33=[Metro_History.Denied];

% Create a Figure to plot stuff in, 9 Graphs Total
figure('Name','Network Indicators','NumberTitle','off');
% First Row: 3 Graphs
    % 1st Subgraph: KPI - Score of the Alternative
        subplot(3,3,1)
        yyaxis left
        p=plot(x1,y1,':',x2,y2,':',x3,y3,':');
        ylabel('Score')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x1,y4,'-',x2,y5,'-',x3,y6,'-');
        ylabel('Accumulated Score')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        title('KPI - Score & Accumulated Score - Comparison')
        %legend('BRT','LRT','Metro')
        
        %plot(x1,y1,x2,y2,x3,y3)
        %title('KPI - Score - Comparison')
        %legend('BRT','LRT','Metro')
    % 2st Subgraph: KPI - Accumulated Score of the Alternative
        subplot(3,3,2)
        plot(x1,y4,x2,y5,x3,y6)
        ylabel('Score')
        xlabel('Iteration#')
        title('KPI - Accumulated Score - Comparison')
        %legend('BRT','LRT','Metro')
    % 3rd Subgraph: KPI - System Length     
        subplot(3,3,3)
        plot(x1,y28,x2,y29,x3,y30)
        ylabel('Length [km]')
        xlabel('Iteration#')
        %legend('BRT','LRT','Metro')
        title('System Length [Km] - Comparison')
% Second Row: 3 KPI Graphs
	% 4th Subgraph: KPI - Beta & Gamma - Comparison
        subplot(3,3,4)
        yyaxis left
        p=plot(x1,y7,'-',x2,y8,'-',x3,y9,'-');
        ylabel('Beta')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x1,y10,':',x2,y11,':',x3,y12,':');
        ylabel('Gamma')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#')
        title('KPI - Beta & Gamma - Comparison')
        %legend('BRT','LRT','Metro')
	% 5th Subgraph: KPI - Diameter - Comparison       
        subplot(3,3,5)
        plot(x1,y13,x2,y14,x3,y15)
        ylabel('Diameter')
        xlabel('Iteration#')
        title('KPI - Diameter - Comparison')
        %legend('BRT','LRT','Metro')
	% 6th Subgraph: KPI - APL - Comparison
        subplot(3,3,6)
        plot(x1,y16,x2,y17,x3,y18)
        ylabel('APL [km]')
        xlabel('Iteration#')
        title('KPI - APL - Comparison')
        %legend('BRT','LRT','Metro')
% Third Row: 3  Performance? Graphs
      % 7th Subgraph: Connected Population - Comparison
        subplot(3,3,7)
        yyaxis left
        p=plot(x1,y22,'-',x2,y23,'-',x3,y24,'-');
        ylabel('Connected Population')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x1,y31,':',x2,y32,':',x3,y33,':');
        ylabel('Denied Ridership')
        xlabel('Iteration#')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        title('Connected Population & Denied Ridership - Comparison')
       % legend('BRT','LRT','Metro')
    % 8th Subgraph: Performance - Remaining Potential 
        subplot(3,3,8)
        plot(x1,y25,x2,y26,x3,y27)
        ylabel('Betw.Centr.')
        xlabel('Iteration#')
        %legend('BRT','LRT','Metro')
        title('Betweenness Centrality - Comparison')
%         title('Average Betw.Centrality - Comparison')
    % 9th Subgraph: Performance - Average Link Load & Max Link Load 
        subplot(3,3,9)
        plot(x1,y19,x2,y20,x3,y21)
        ylabel('Load [Persons]')
        xlabel('Iteration#')        
        %legend('BRT','LRT','Metro')
        title('Perf - Average Link Load - Comparison')

