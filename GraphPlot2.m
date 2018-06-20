function GraphPlot2(R,phi,S,Nodes,BRT_45,BRT_60,Metro_45)%,LRT_60,M_45)

set(groot,'defaultLineLineWidth','remove')
% Figures - BRT SPEEDS
figure('Name','B45_Norm','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,BRT_45(end).Links,2000,20000);
    colormap jet
    caxis([0 4]);
figure('Name','B60_Norm','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,BRT_60(end).Links,2000,20000);
    colormap jet
    caxis([0 4]);
    
% Figures - LRT SPEEDS
% figure('Name','L35_Norm','NumberTitle','off');
%     ax = gca;
%     ax.Visible = 'off';
%     DrawGrid(R,phi,S);
%     DrawNetwork(Nodes,LRT_35(end).Links,3500,35000);
%     colormap jet    
%     caxis([0.1 2]);
% figure('Name','L60_Norm','NumberTitle','off');
%     ax = gca;
%     ax.Visible = 'off';
%     DrawGrid(R,phi,S);
%     DrawNetwork(Nodes,LRT_60(end).Links,3500,35000);
%     colormap jet    
%     caxis([0.1 2]);
    
% Figures - Metro SPEEDS
% figure('Name','M35_Norm','NumberTitle','off');
%     ax = gca;
%     ax.Visible = 'off';
%     DrawGrid(R,phi,S);
%     DrawNetwork(Nodes,M_35(end).Links,8000,80000);
%     colormap jet    
%     caxis([0.1 2]);
figure('Name','M45_Norm','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,Metro_45(end).Links,8000,80000);
    colormap jet    
    caxis([0 4]);

% FolderName = 'Graphs\RawGraphs';   % destination folder
% FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
% for iFig = 1:length(FigList)
%   FigHandle = FigList(iFig);
%   set(FigHandle,'units','normalized','outerposition',[0 0 1 1])
%   FigName   = strcat(get(FigHandle, 'Name'), '2.png');  
%   saveas(FigHandle, fullfile(FolderName, FigName));
% end
% close all    