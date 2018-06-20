function CompareSensitivity(BRT_U,BRT_45,BRT_60,LRT_U,M_U,M_45)
% Set X-Asis for plotting
x1=1:1:numel(BRT_U);x2=1:1:numel(BRT_45);x3=1:1:numel(BRT_60);
x4=1:1:numel(LRT_U);x5=1:1:numel(M_U);   x6=1:1:numel(M_45);

set(groot,'defaultLineLineWidth',2)
% Figure 1: Length Comparison
figure('Name','SensCompare_TLL');
    subplot(2,1,1)
    plot(x1,[BRT_U.TLL],x2,[BRT_45.TLL],x3,[BRT_60.TLL])
    ylim([0 1650]);
    ylabel('Length','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - SA - System Length Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    subplot(2,1,2)
    plot(x2,[BRT_45.TLL],x4,[LRT_U.TLL],x6,[M_45.TLL])
    ylim([0 1650]);
    ylabel('Length','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - System Length Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')

% Figure 2: Beta&Gamma Comparison
figure('Name','SensCompare_B_C');
        % Uniform Population - V_MODE MODES ANALYSIS
        subplot(2,1,1)
        yyaxis left
        p=plot(x1,[BRT_U.Beta],'-',x2,[BRT_45.Beta],'-',x3,[BRT_60.Beta],'-');
        ylim([0 2]);
        ylabel('Beta','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x1,[BRT_U.Gamma],':',x2,[BRT_45.Gamma],':',x3,[BRT_60.Gamma],':');
        ylim([0 1]);
        ylabel('Gamma','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#','FontSize',12,'FontWeight','bold')
        title('Uniform Population - SA - Beta,Gamma Comparison')
        % Uniform Population - ALPHA -  MODES ANALYSIS
        subplot(2,1,2)
        yyaxis left
        p=plot(x2,[BRT_45.Beta],'-',x4,[LRT_U.Beta],'-',x6,[M_45.Beta],'-');
        ylim([0 2]);
        ylabel('Beta','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        yyaxis right
        p=plot(x2,[BRT_45.Gamma],':',x4,[LRT_U.Gamma],':',x6,[M_45.Gamma],':');
        ylim([0 1]);
        ylabel('Gamma','FontSize',12,'FontWeight','bold')
        p(1).Color= [0 0.4470 0.7410];
        p(2).Color= [0.8500 0.3250 0.0980];
        p(3).Color= [0.9290 0.6940 0.1250];
        xlabel('Iteration#','FontSize',12,'FontWeight','bold')
        title('Uniform Population - SA - Beta,Gamma Comparison')

% Figure 3: Diameter Comparison
figure('Name','SensCompare_Diam');
    subplot(2,1,1)
    plot(x1,[BRT_U.Diameter],x2,[BRT_45.Diameter],x3,[BRT_60.Diameter])
	ylim([0 90]);
    ylabel('Diameter [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - SA  - Diameter Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(2,1,2)
    plot(x2,[BRT_45.Diameter],x4,[LRT_U.Diameter],x6,[M_45.Diameter])
    ylim([0 90]);
    ylabel('Diameter [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - Diameter Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')
    
% Figure 4: Average Path Length
figure('Name','SensCompare_APL');
    subplot(2,1,1)
	plot(x1,[BRT_U.APL],x2,[BRT_45.APL],x3,[BRT_60.APL])
    ylim([0 40]);
    ylabel('APL [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - SA - Avereage Shortest Path Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(2,1,2)
    plot(x2,[BRT_45.APL],x4,[LRT_U.APL],x6,[M_45.APL])
    ylim([0 40]);    
    ylabel('APL [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - Avereage Shortest Path Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')
    
   
% Figure 5: Potential Ridership
figure('Name','SensCompare_PR');
    subplot(2,1,1)
    plot(x1,[BRT_U.Ridership],x2,[BRT_45.Ridership],x3,[BRT_60.Ridership])
    ylabel('Ridership [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - SA - Potential Ridership Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(2,1,2)
    plot(x2,[BRT_45.Ridership],x4,[LRT_U.Ridership],x6,[M_45.Ridership])
    ylabel('Ridership [km]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - Potential Ridership Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')
    
% Figure 6: Denied Ridership
figure('Name','SensCompare_Denied');    
    subplot(2,1,1)
    plot(x1,[BRT_U.Denied],x2,[BRT_45.Denied],x3,[BRT_60.Denied])
	ylim([2.0E4 1.5E7]);
    ylabel('Denied [PAX]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - SA - Denied Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(2,1,2)
	plot(x2,[BRT_45.Denied],x4,[LRT_U.Denied],x6,[M_45.Denied])
	ylim([2.0E4 1.5E7]);
    ylabel('Denied [PAX]','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - Denied Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')
    
% Figure 7: Betweenness Centrality
figure('Name','SensCompare_AvgBc');  
    subplot(2,1,1)
    plot(x1,[BRT_U.AvgBc],x2,[BRT_45.AvgBc],x3,[BRT_60.AvgBc])
    ylabel('AvgBc','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - SA - AvgBc Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(2,1,2)
    plot(x2,[BRT_45.AvgBc],x4,[LRT_U.AvgBc],x6,[M_45.AvgBc])
    ylabel('AvgBc','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - AvgBc Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')
 
% Figure 8: Total Travel Time
figure('Name','SensCompare_TTT');  
    subplot(2,1,1)
    plot(x1,[BRT_U.TTT],x2,[BRT_45.TTT],x3,[BRT_60.TTT])
    ylim([2.0E6 4.0E6]);
    ylabel('TTT','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - SA - TotalTravelTime Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(2,1,2)
    plot(x2,[BRT_45.TTT],x4,[LRT_U.TTT],x6,[M_45.TTT])
    ylim([2.0E6 4.0E6]);
    ylabel('TTT','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - TotalTravelTime Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')

% Figure 9: Ringness
figure('Name','SensCompare_Ring');  
    subplot(2,1,1)
    plot(x1,[BRT_U.Ringness],x2,[BRT_45.Ringness],x3,[BRT_60.Ringness])
    ylim([0 1]);
    ylabel('Ringness','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Bus Rapid Transit - SA - Ringness Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(2,1,2)
    plot(x2,[BRT_45.Ringness],x4,[LRT_U.Ringness],x6,[M_45.Ringness])
    ylim([0 1]);
    ylabel('Ringness','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - Ringness Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')

% Figure 10: AvgDetour
figure('Name','SensCompare_AvgDetour');  
    subplot(3,1,1)
    plot(x1,[BRT_U.AvgDetour],x2,[BRT_45.AvgDetour],x3,[BRT_60.AvgDetour])
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - AvgDetour Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(3,1,2)
    plot(x2,[BRT_45.AvgDetour],x4,[LRT_U.AvgDetour],x6,[M_45.AvgDetour])
    ylabel('AvgDetour','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - AvgDetour Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')

% Figure 11: LoadRatio
figure('Name','SensCompare_AvgLoadRatio');  
    subplot(2,1,1)
    plot(x1,[BRT_U.AvgLoadRatio],x2,[BRT_45.AvgLoadRatio],x3,[BRT_60.AvgLoadRatio])
    ylim([0 45]);
    ylabel('AvgLoadRatio','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - AvgLoadRatio Comparison')
    legend({'BRT_{35}','BRT_{45}','BRT_{60}'},'Location','northeastoutside')
    
    subplot(2,1,2)
    plot(x2,[BRT_45.AvgLoadRatio],x4,[LRT_U.AvgLoadRatio],x6,[M_45.AvgLoadRatio])
    ylim([0 45]);
    ylabel('AvgLoadRatio','FontSize',12,'FontWeight','bold')
    xlabel('Iteration#','FontSize',12,'FontWeight','bold')
    title('Uniform Population - SA - AvgLoadRatio Comparison')
    legend({'BRT_{45}','LRT_{45}','Metro_{45}'},'Location','northeastoutside')

FolderName = 'Graphs\Sensitivity';   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  set(FigHandle,'units','normalized','outerposition',[0 0 1 1])
  FigName   = strcat(get(FigHandle, 'Name'), '.png');  
  saveas(FigHandle, fullfile(FolderName, FigName));
end
close all
