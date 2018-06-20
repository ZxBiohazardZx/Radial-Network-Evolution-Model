function CompareMode(BRT_U,BRT_L,BRT_E,LRT_U,LRT_L,LRT_E,M_U,M_L,M_E)
% Set X-Asis for plotting
x1=1:1:numel(BRT_U);x2=1:1:numel(BRT_L);x3=1:1:numel(BRT_E);
x4=1:1:numel(LRT_U);x5=1:1:numel(LRT_L);x6=1:1:numel(LRT_E);
x7=1:1:numel(M_U);  x8=1:1:numel(M_L);  x9=1:1:numel(M_E);

set(groot,'defaultLineLineWidth',2)
% Figure 1: Length Comparison
figure('Name','ModeCompare_TLL');
    subplot(3,1,1)
    plot(x1,[BRT_U.TLL],x4,[LRT_U.TLL],x7,[M_U.TLL])
    ylim([0 1650]);
    ylabel('Length','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - System Length Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.TLL],x5,[LRT_L.TLL],x8,[M_L.TLL])
    ylim([0 1650]);
    ylabel('Length','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - System Length Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

    
    subplot(3,1,3)
    plot(x3,[BRT_E.TLL],x6,[LRT_E.TLL],x9,[M_E.TLL])
    ylim([0 1650]);
    ylabel('Length','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - System Length Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

% Figure 2: Beta&Gamma Comparison
figure('Name','ModeCompare_B_C');
        % Uniform Population
        subplot(3,1,1)
        yyaxis left
        p=plot(x1,[BRT_U.Beta],'-',x4,[LRT_U.Beta],'-',x7,[M_U.Beta],'-');
        ylim([0 2]);
        ylabel('Beta','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x1,[BRT_U.Gamma],':',x4,[LRT_U.Gamma],':',x7,[M_U.Gamma],':');
        ylim([0 1]);
        ylabel('Gamma','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#','FontSize',12,'FontWeight','bold')
        title('Uniform Population - Beta,Gamma Comparison')
        % Linear Decay Population
        subplot(3,1,2)
        yyaxis left
        p=plot(x2,[BRT_L.Beta],'-',x5,[LRT_L.Beta],'-',x8,[M_L.Beta],'-');
        ylim([0 2]);
        ylabel('Beta','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x2,[BRT_L.Gamma],':',x5,[LRT_L.Gamma],':',x8,[M_L.Gamma],':');
        ylim([0 1]);
        ylabel('Gamma','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#','FontSize',12,'FontWeight','bold')
        title('Linear Decay Population - Beta,Gamma Comparison')
        % Exponential Decay Population       
        subplot(3,1,3)
        yyaxis left
        p=plot(x3,[BRT_E.Beta],'-',x6,[LRT_E.Beta],'-',x9,[M_E.Beta],'-');
        ylim([0 2]);
        ylabel('Beta','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x3,[BRT_E.Gamma],':',x6,[LRT_E.Gamma],':',x9,[M_E.Gamma],':');
        ylim([0 1]);
        ylabel('Gamma','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#','FontSize',12,'FontWeight','bold')
        title('Exponential Decay Population - Beta,Gamma Comparison')

% Figure 3: Diameter Comparison
figure('Name','ModeCompare_Diam');
    subplot(3,1,1)
    plot(x1,[BRT_U.Diameter],x4,[LRT_U.Diameter],x7,[M_U.Diameter])
	ylim([0 90]);
    ylabel('Diameter [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - Diameter Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.Diameter],x5,[LRT_L.Diameter],x8,[M_L.Diameter])
    ylim([0 90]);
    ylabel('Diameter [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - Diameter Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.Diameter],x6,[LRT_E.Diameter],x9,[M_E.Diameter])
    ylim([0 90]);
    ylabel('Diameter [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - Diameter Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

% Figure 4: Average Path Length
figure('Name','ModeCompare_APL');
    subplot(3,1,1)
	plot(x1,[BRT_U.APL],x4,[LRT_U.APL],x7,[M_U.APL])
    ylim([0 40]);
    ylabel('APL [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - Avereage Shortest Path Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.APL],x5,[LRT_L.APL],x8,[M_L.APL])
    ylim([0 40]);    
    ylabel('APL [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - Avereage Shortest Path Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.APL],x6,[LRT_E.APL],x9,[M_E.APL])
    ylim([0 40]);    
    ylabel('APL [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - Avereage Shortest Path Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
   
% Figure 5: Potential Ridership
figure('Name','ModeCompare_PR');
    subplot(3,1,1)
    plot(x1,[BRT_U.Ridership],x4,[LRT_U.Ridership],x7,[M_U.Ridership])
    ylabel('Ridership [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - Potential Ridership Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.Ridership],x5,[LRT_L.Ridership],x8,[M_L.Ridership])
    ylabel('Ridership [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - Potential Ridership Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.Ridership],x6,[LRT_E.Ridership],x9,[M_E.Ridership])
    ylabel('Ridership [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - Potential Ridership Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
   
% Figure 6: Denied Ridership
figure('Name','ModeCompare_Denied');    
    subplot(3,1,1)
    plot(x1,[BRT_U.Denied],x4,[LRT_U.Denied],x7,[M_U.Denied])
	ylim([2.0E4 1.5E7]);
    ylabel('Denied [PAX]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - Denied Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
	plot(x2,[BRT_L.Denied],x5,[LRT_L.Denied],x8,[M_L.Denied])
	ylim([2.0E4 1.5E7]);
    ylabel('Denied [PAX]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - Denied Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.Denied],x6,[LRT_E.Denied],x9,[M_E.Denied])
    ylim([2.0E4 1.5E7]);
    ylabel('Denied [PAX]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - Denied Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
% Figure 7: Betweenness Centrality
figure('Name','ModeCompare_AvgBc');  
    subplot(3,1,1)
    plot(x1,[BRT_U.AvgBc],x4,[LRT_U.AvgBc],x7,[M_U.AvgBc])
    ylabel('AvgBc','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - AvgBc Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.AvgBc],x5,[LRT_L.AvgBc],x8,[M_L.AvgBc])
    ylabel('AvgBc','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - AvgBc Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.AvgBc],x6,[LRT_E.AvgBc],x9,[M_E.AvgBc])
    ylabel('AvgBc','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - AvgBc Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

% Figure 8: Average Link Load
figure('Name','ModeCompare_ALL');  
    subplot(3,1,1)
    plot(x1,[BRT_U.AverageLinkLoad],x4,[LRT_U.AverageLinkLoad],x7,[M_U.AverageLinkLoad])
    ylabel('AverageLinkLoad','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - AverageLinkLoad Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.AverageLinkLoad],x5,[LRT_L.AverageLinkLoad],x8,[M_L.AverageLinkLoad])
    ylabel('AverageLinkLoad','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - AverageLinkLoad Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.AverageLinkLoad],x6,[LRT_E.AverageLinkLoad],x9,[M_E.AverageLinkLoad])
    ylabel('AverageLinkLoad')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - AverageLinkLoad Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

% Figure 9: Total Travel Time
figure('Name','ModeCompare_TTT');  
    subplot(3,1,1)
    plot(x1,[BRT_U.TTT],x4,[LRT_U.TTT],x7,[M_U.TTT])
    ylim([2.0E6 4.0E6]);
    ylabel('TTT','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - TotalTravelTime Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.TTT],x5,[LRT_L.TTT],x8,[M_L.TTT])
    ylim([2.0E6 4.0E6]);
    ylabel('TTT','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - TotalTravelTime Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.TTT],x6,[LRT_E.TTT],x9,[M_E.TTT])
    ylim([2.0E6 4.0E6]);
    ylabel('TTT','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - TotalTravelTime Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

% Figure 10: Ringness
figure('Name','ModeCompare_Ring');  
    subplot(3,1,1)
    plot(x1,[BRT_U.Ringness],x4,[LRT_U.Ringness],x7,[M_U.Ringness])
    ylim([0 1]);
    ylabel('Ringness','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - Ringness Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.Ringness],x5,[LRT_L.Ringness],x8,[M_L.Ringness])
    ylim([0 1]);
    ylabel('Ringness','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - Ringness Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.Ringness],x6,[LRT_E.Ringness],x9,[M_E.Ringness])
    ylim([0 1]);
    ylabel('Ringness','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - Ringness Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

% Figure 11: AvgDetour
figure('Name','ModeCompare_AvgDetour');  
    subplot(3,1,1)
    plot(x1,[BRT_U.AvgDetour],x4,[LRT_U.AvgDetour],x7,[M_U.AvgDetour])
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - AvgDetour Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.AvgDetour],x5,[LRT_L.AvgDetour],x8,[M_L.AvgDetour])
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - AvgDetour Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.AvgDetour],x6,[LRT_E.AvgDetour],x9,[M_E.AvgDetour])
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - AvgDetour Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

% Figure 12: LoadRatio
figure('Name','ModeCompare_AvgLoadRatio');  
    subplot(3,1,1)
    plot(x1,[BRT_U.AvgLoadRatio],x4,[LRT_U.AvgLoadRatio],x7,[M_U.AvgLoadRatio])
    ylim([0 45]);
    ylabel('AvgLoadRatio','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - AvgLoadRatio Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_L.AvgLoadRatio],x5,[LRT_L.AvgLoadRatio],x8,[M_L.AvgLoadRatio])
    ylim([0 45]);
    ylabel('AvgLoadRatio','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Linear Decay Population - AvgLoadRatio Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x3,[BRT_E.AvgLoadRatio],x6,[LRT_E.AvgLoadRatio],x9,[M_E.AvgLoadRatio])
    ylim([0 45]);
    ylabel('AvgLoadRatio','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Exponential Decay Population - AvgLoadRatio Comparison')
    legend({'BRT','LRT','Metro'},'Location','northeastoutside')

FolderName = 'Graphs\CompareMode';   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  set(FigHandle,'units','normalized','outerposition',[0 0 1 1])
  FigName   = strcat(get(FigHandle, 'Name'), '.png');  
  saveas(FigHandle, fullfile(FolderName, FigName));
end
close all
