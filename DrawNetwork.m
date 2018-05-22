function DrawNetwork(Nodes,Links,CapValue,MaxCapacity)
%--------------------------------------------------------------------------
% - INPUT:  {Nodes}, {Links}
% - OUTPUT: Figure displaying network state
% - METHOD: Draws network elements based on coordinates
%--------------------------------------------------------------------------
hold on
plotNodes(Nodes);
plotLinks(Nodes,Links,CapValue,MaxCapacity);
hold off
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

function plotLinks(Nodes,Links,CapValue,MaxCapacity)
%--------------------
%-- Plot the Links --
%--------------------
for n=1:1:numel(Links) % For each Link:
    NormCap=Links(n).Capacity / CapValue; 
    NormCap2= Links(n).Capacity / MaxCapacity; 
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
        surf(xx,yy,zz,cc,'EdgeColor','interp','FaceColor','none','LineWidth',5*NormCap2) ;
        colormap(jet) ;       %// assign the colormap
        shading flat          %// so each line segment has a plain color
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
        surf(xx,yy,zz,cc,'EdgeColor','interp','FaceColor','none','LineWidth',5*NormCap2) ;
        
        
    end
end

end
