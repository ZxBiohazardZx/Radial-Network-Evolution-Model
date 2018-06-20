function GraphPlot(R,phi,S,Nodes,BRT_U,BRT_L,BRT_E,LRT_U,LRT_L,LRT_E,M_U,M_L,M_E)

set(groot,'defaultLineLineWidth','remove')
% Figure 1: Length Comparison
figure('Name','BU_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,BRT_U(end).Links,2000,20000);
    colormap copper
    caxis([0 192]);
figure('Name','BL_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,BRT_L(end).Links,2000,20000);
    colormap copper
    caxis([0 192]);
figure('Name','BE_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,BRT_E(end).Links,2000,20000);
    colormap copper  
    caxis([0 192]);
    
figure('Name','LU_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,LRT_U(end).Links,3500,35000);
    colormap copper  
    caxis([0 192]);
figure('Name','LL_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,LRT_L(end).Links,3500,35000);
    colormap copper  
    caxis([0 192]);
figure('Name','LE_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,LRT_E(end).Links,3500,35000);
    colormap copper  
    caxis([0 192]);
    
figure('Name','MU_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,M_U(end).Links,8000,80000);
    colormap copper  
    caxis([0 192]);
figure('Name','ML_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,M_L(end).Links,8000,80000);
    colormap copper  
    caxis([0 192]);
figure('Name','ME_Raw','NumberTitle','off');
    ax = gca;
    ax.Visible = 'off';
    DrawGrid(R,phi,S);
    DrawNetwork(Nodes,M_E(end).Links,8000,80000);
    colormap copper  
    caxis([0 192]);

FolderName = 'Graphs\History';   % destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  set(FigHandle,'units','normalized','outerposition',[0 0 1 1])
  FigName   = strcat(get(FigHandle, 'Name'), '2.png');  
  saveas(FigHandle, fullfile(FolderName, FigName));
end
close all    