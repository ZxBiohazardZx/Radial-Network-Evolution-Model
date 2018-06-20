function ComparePop(BRT_U,BRT_L,BRT_E,LRT_U,LRT_L,LRT_E,M_U,M_L,M_E)
% Set X-Asis for plotting
x1=1:1:numel(BRT_U);x2=1:1:numel(BRT_L);x3=1:1:numel(BRT_E);
x4=1:1:numel(LRT_U);x5=1:1:numel(LRT_L);x6=1:1:numel(LRT_E);
x7=1:1:numel(M_U);  x8=1:1:numel(M_L);  x9=1:1:numel(M_E);

set(groot,'defaultLineLineWidth',2)

% Figure 1: Length Comparison
figure('Name','PopCompare_TLL');
    subplot(3,1,1)
    plot(x1,[BRT_U.TLL],x2,[BRT_L.TLL],x3,[BRT_E.TLL])
    ylim([0 1650]);
    ylabel('Length','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - System Length Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.TLL],x5,[LRT_L.TLL],x6,[LRT_E.TLL])
    ylim([0 1650]);
    ylabel('Length','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - System Length Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.TLL],x8,[M_L.TLL],x9,[M_E.TLL])
    ylim([0 1650]);
    ylabel('Length','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - System Length Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
% Figure 2: Beta&Gamma Comparison
figure('Name','PopCompare_B_C');
        % Bus Rapid Transit
        subplot(3,1,1)
        yyaxis left
        p=plot(x1,[BRT_U.Beta],'-',x2,[BRT_L.Beta],'-',x3,[BRT_E.Beta],'-');
        ylim([0 2]);
        ylabel('Beta','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x1,[BRT_U.Gamma],':',x2,[BRT_L.Gamma],':',x3,[BRT_E.Gamma],':');
        ylim([0 1]);
        ylabel('Gamma','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#','FontSize',12,'FontWeight','bold')
        title('BRT - Beta & Gamma - Comparison')
        % Light Rail Transit
        subplot(3,1,2)
        yyaxis left
        p=plot(x4,[LRT_U.Beta],'-',x5,[LRT_L.Beta],'-',x6,[LRT_E.Beta],'-');
        ylim([0 2]);
        ylabel('Beta','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x4,[LRT_U.Gamma],':',x5,[LRT_L.Gamma],':',x6,[LRT_E.Gamma],':');
        ylim([0 1]);
        ylabel('Gamma','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#','FontSize',12,'FontWeight','bold')
        title('LRT - Beta & Gamma - Comparison')
        % Rapid Transit        
        subplot(3,1,3)
        yyaxis left
        p=plot(x7,[M_U.Beta],'-',x8,[M_L.Beta],'-',x9,[M_E.Beta],'-');
        ylim([0 2]);
        ylabel('Beta','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x7,[M_U.Gamma],':',x8,[M_L.Gamma],':',x9,[M_E.Gamma],':');
        ylim([0 1]);
        ylabel('Gamma','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#','FontSize',12,'FontWeight','bold')
        title('Metro - Beta & Gamma - Comparison')

% Figure 3: Diameter Comparison
figure('Name','PopCompare_Diam');
    subplot(3,1,1)
    plot(x1,[BRT_U.Diameter],x2,[BRT_L.Diameter],x3,[BRT_E.Diameter])
    ylim([0 90]);
    ylabel('Diameter [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - Diameter Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.Diameter],x5,[LRT_L.Diameter],x6,[LRT_E.Diameter])
    ylim([0 90]);
    ylabel('Diameter [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - Diameter Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.Diameter],x8,[M_L.Diameter],x9,[M_E.Diameter])
    ylim([0 90]);
    ylabel('Diameter [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - Diameter Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
        

% Figure 4: Average Path Length
figure('Name','PopCompare_APL');
    subplot(3,1,1)
    plot(x1,[BRT_U.APL],x2,[BRT_L.APL],x3,[BRT_E.APL])
    ylim([0 40]);
    ylabel('APL [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - Avereage Shortest Path Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.APL],x5,[LRT_L.APL],x6,[LRT_E.APL])
    ylim([0 40]);
    ylabel('APL [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - Avereage Shortest Path Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.APL],x8,[M_L.APL],x9,[M_E.APL])
    ylim([0 40]);
    ylabel('APL [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - Avereage Shortest Path Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
   
% Figure 5: Potential Ridership
figure('Name','PopCompare_PR');
    subplot(3,1,1)
    plot(x1,[BRT_U.Ridership],x2,[BRT_L.Ridership],x3,[BRT_E.Ridership])
    ylabel('Ridership [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - Potential Ridership Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.Ridership],x5,[LRT_L.Ridership],x6,[LRT_E.Ridership])
    ylabel('Ridership [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - Potential Ridership Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.Ridership],x8,[M_L.Ridership],x9,[M_E.Ridership])
    ylabel('Ridership [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - Potential Ridership Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
   
% Figure 6: Denied Ridership
figure('Name','PopCompare_Denied');  
    subplot(3,1,1)
    plot(x1,[BRT_U.Denied],x2,[BRT_L.Denied],x3,[BRT_E.Denied])
    ylim([2.0E4 1.5E7]);
    ylabel('Denied [PAX]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - Denied Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.Denied],x5,[LRT_L.Denied],x6,[LRT_E.Denied])
    ylim([2.0E4 1.5E7]);
    ylabel('Denied [PAX]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - Denied Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.Denied],x8,[M_L.Denied],x9,[M_E.Denied])
    ylim([2.0E4 1.5E7]);
    ylabel('Denied [PAX]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - Denied Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
% Figure 7: Betweenness Centrality
figure('Name','PopCompare_AvgBc');    
    subplot(3,1,1)
    plot(x1,[BRT_U.AvgBc],x2,[BRT_L.AvgBc],x3,[BRT_E.AvgBc])
    ylabel('AvgBc','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - AvgBc Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.AvgBc],x5,[LRT_L.AvgBc],x6,[LRT_E.AvgBc])
    ylabel('AvgBc','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - AvgBc Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.AvgBc],x8,[M_L.AvgBc],x9,[M_E.AvgBc])
    ylabel('AvgBc','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - AvgBc Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')

% Figure 8: Average Link Load
figure('Name','PopCompare_ALL');    
    subplot(3,1,1)
    plot(x1,[BRT_U.AverageLinkLoad],x2,[BRT_L.AverageLinkLoad],x3,[BRT_E.AverageLinkLoad])
    ylabel('AverageLinkLoad')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - AverageLinkLoad Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.AverageLinkLoad],x5,[LRT_L.AverageLinkLoad],x6,[LRT_E.AverageLinkLoad])
    ylabel('AverageLinkLoad')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - AverageLinkLoad Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.AverageLinkLoad],x8,[M_L.AverageLinkLoad],x9,[M_E.AverageLinkLoad])
    ylabel('AverageLinkLoad')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - AverageLinkLoad Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')

% Figure 9: Total Travel Time
figure('Name','PopCompare_TTT');    
    subplot(3,1,1)
    plot(x1,[BRT_U.TTT],x2,[BRT_L.TTT],x3,[BRT_E.TTT])
    ylim([2.0E6 4.0E6]);
    ylabel('TTT','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - TotalTravelTime Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.TTT],x5,[LRT_L.TTT],x6,[LRT_E.TTT])
    ylim([2.0E6 4.0E6]);
    ylabel('TTT','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - TotalTravelTime Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.TTT],x8,[M_L.TTT],x9,[M_E.TTT])
    ylim([2.0E6 4.0E6]);
    ylabel('TTT','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - TotalTravelTime Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')

% Figure 10: Ringness
figure('Name','PopCompare_Ring');    
    subplot(3,1,1)
    plot(x1,[BRT_U.Ringness],x2,[BRT_L.Ringness],x3,[BRT_E.Ringness])
    ylim([0 1]);
    ylabel('Ringness','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - Ringness Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.Ringness],x5,[LRT_L.Ringness],x6,[LRT_E.Ringness])
    ylim([0 1]);
    ylabel('Ringness','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - Ringness Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.Ringness],x8,[M_L.Ringness],x9,[M_E.Ringness])
    ylim([0 1]);
    ylabel('Ringness','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - Ringness Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')

% Figure 11: Detour
figure('Name','PopCompare_AvgDetour');    
    subplot(3,1,1)
    plot(x1,[BRT_U.AvgDetour],x2,[BRT_L.AvgDetour],x3,[BRT_E.AvgDetour])
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - AvgDetour Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.AvgDetour],x5,[LRT_L.AvgDetour],x6,[LRT_E.AvgDetour])
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - AvgDetour Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.AvgDetour],x8,[M_L.AvgDetour],x9,[M_E.AvgDetour])
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - AvgDetour Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')

% Figure 12: AvgLoadRatio
figure('Name','PopCompare_AvgLoadRatio');    
    subplot(3,1,1)
    plot(x1,[BRT_U.AvgLoadRatio],x2,[BRT_L.AvgLoadRatio],x3,[BRT_E.AvgLoadRatio])
    ylim([0 45]);
    ylabel('AvgLoadRatio','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - AvgLoadRatio Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x4,[LRT_U.AvgLoadRatio],x5,[LRT_L.AvgLoadRatio],x6,[LRT_E.AvgLoadRatio])
    ylim([0 45]);
    ylabel('AvgLoadRatio','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Light Rail Transit - AvgLoadRatio Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')
    
    subplot(3,1,3)
    plot(x7,[M_U.AvgLoadRatio],x8,[M_L.AvgLoadRatio],x9,[M_E.AvgLoadRatio])
    ylim([0 45]);
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Rapid Transit - AvgLoadRatio Comparison')
    legend({'Uniform','Linear','Exponential'},'Location','northeastoutside')


    
    
FolderName = 'Graphs\ComparePop';   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  set(FigHandle,'units','normalized','outerposition',[0 0 1 1])
  FigName   = strcat(get(FigHandle, 'Name'), '.png');  
  saveas(FigHandle, fullfile(FolderName, FigName));
end
close all