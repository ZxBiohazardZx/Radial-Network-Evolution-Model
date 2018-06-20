function MakeVideo(Nodes,History,CapValue,MaxCapacity,R,phi,S)
% create the video writer with 1 fps
writerObj = VideoWriter('myVideo.avi');
writerObj.FrameRate = 1;

% open the video writer
open(writerObj);

clf % Clear Figure Window (CLF)
f1=figure('visible','off');
for n=1:1:numel(History)
    DrawGrid(R,phi,S);
    set(gca,'NextPlot','replacechildren') ;
    DrawNetwork(Nodes,History(n).Links,CapValue,MaxCapacity)
    drawnow;
    set(gca, 'Visible', 'off')
    frame = getframe(f1);
    writeVideo(writerObj, frame);   
end
% close the writer object
close(writerObj);

%Save Video
% v = VideoWriter('Test.avi');
% open(v);
% writeVideo(v,F);
% close(v)