function VisualiseNetworkEvo(BRT_U,BRT_L,BRT_E,LRT_U,LRT_L,LRT_E,Metro_U,Metro_L,Metro_E,R,phi,S,Nodes)
    VisualiseEvo(BRT_U,Nodes,R,phi,S,'BRT_U');
    VisualiseEvo(BRT_L,Nodes,R,phi,S,'BRT_L');
    VisualiseEvo(BRT_E,Nodes,R,phi,S,'BRT_E');
    VisualiseEvo(LRT_U,Nodes,R,phi,S,'LRT_U');
    VisualiseEvo(LRT_L,Nodes,R,phi,S,'LRT_L');
    VisualiseEvo(LRT_E,Nodes,R,phi,S,'LRT_E');
    VisualiseEvo(Metro_U,Nodes,R,phi,S,'Metro_U');
    VisualiseEvo(Metro_L,Nodes,R,phi,S,'Metro_L');
    VisualiseEvo(Metro_E,Nodes,R,phi,S,'Metro_E');
    
    
FolderName = 'Graphs\History';   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  set(FigHandle,'units','normalized','outerposition',[0 0 1 1])
  FigName   = strcat(get(FigHandle, 'Name'), '.png');  
  saveas(FigHandle, fullfile(FolderName, FigName));
end
close all


end

function VisualiseEvo(History,Nodes,R,phi,S,Name)
set(groot,'defaultLineLineWidth','remove')
%New Figure for Network Visualisation
figure('Name',Name,'NumberTitle','off');
DrawGrid(R,phi,S);

hold on
plotNodes(Nodes);
plotLinks(Nodes,History(end).Links);
hold off
title('Network History')
end


function plotNodes(Nodes)
    %--------------------
    %-- Plot the Nodes --
    %--------------------
    hold on % Hold the figure to plot multiple things in 1 figure
    axis equal % Equal Axis ensures polar plot remains scaled
    for n=1:1:numel(Nodes) % For each Node:
        %find the coordinates we need
        xplot= Nodes(n).r*cos(Nodes(n).phi);
        yplot= Nodes(n).r*sin(Nodes(n).phi);
        plot(xplot,yplot,'ro'); % plot the nodes as red circles
    end
end

function plotLinks(Nodes,Links)
%--------------------
%-- Plot the Links --
%--------------------
for n=1:1:numel(Links) % For each Link:
    NormCap=n;
    %determine the type (Ring/Radial) using r coordinate:
    DiffR=Nodes(Links(n).EndNode).r - Nodes(Links(n).StartNode).r;
    if DiffR == 0 %then this is a RING (Same radius, thus ringline)
        % Angle phi_grid from Start to End (Segment) in steps of 0.01
        if(Nodes(Links(n).EndNode).phi == 0) %If a EndNode has phi=0
            phi_grid=Nodes(Links(n).StartNode).phi:0.1:2*pi;
        elseif Nodes(Links(n).StartNode).phi ==0 && Nodes(Links(n).EndNode).phi >= pi %If a StartNode has phi=0 AND endnode is > pi away
            phi_grid=Nodes(Links(n).EndNode).phi:0.1:2*pi;
        else
            phi_grid=Nodes(Links(n).StartNode).phi:0.1:Nodes(Links(n).EndNode).phi;    
        end
        %Temp - Generate X,Y,Z
        x=real(Nodes(Links(n).StartNode).r*exp(1i*phi_grid));
        y=imag(Nodes(Links(n).StartNode).r*exp(1i*phi_grid));
        xx = [x' x'];
        yy = [y' y'];
        zz=zeros(size(xx));
        cc = ones(size(xx)).*[NormCap NormCap];
        surf(xx,yy,zz,cc,'EdgeColor','interp','FaceColor','none','LineWidth',2) ;
        colormap(copper) ;       %// assign the colormap
        shading flat          %// so each line segment has a plain color
        colorbar
        view(2) %// view(0,90)%// set view in X-Y plane
        
        % plot the segment
        %plot(real(Nodes(Links(n).StartNode).r*exp(1i*phi_grid)),imag(Nodes(Links(n).StartNode).r*exp(1i*phi_grid)),'-','LineWidth',NormCap)
    else %it is a radial (r1=/r2)
        x1=Nodes(Links(n).StartNode).r*cos(Nodes(Links(n).StartNode).phi);
        x2=Nodes(Links(n).EndNode).r*cos(Nodes(Links(n).EndNode).phi);
        y1=Nodes(Links(n).StartNode).r*sin(Nodes(Links(n).StartNode).phi);
        y2=Nodes(Links(n).EndNode).r*sin(Nodes(Links(n).EndNode).phi);
        %xplot= [x1,x2];
        %yplot= [y1,y2];
        %plot(xplot,yplot,'-','LineWidth',NormCap);
        xx = [[x1 x2]' [x1 x2]'];
        yy = [[y1 y2]' [y1 y2]'];
        zz=zeros(size(xx));
        cc = ones(size(xx)).*[NormCap NormCap];
        surf(xx,yy,zz,cc,'EdgeColor','interp','FaceColor','none','LineWidth',2) ;
        
        
    end
end

end




% subplot(3,3,9)
% plot(x,y10);
% title('Sum PT Users')
