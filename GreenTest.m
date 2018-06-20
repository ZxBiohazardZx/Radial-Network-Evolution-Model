clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
 
grayImage = imread('343a.tiff');
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
    % It's not really gray scale like we expected - it's color.
    % Convert it to gray scale by taking only the green channel.
    grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off')
 
% Compute Laplacian Image
laplacianKernel = [-1,-1,-1;-1,8,-1;-1,-1,-1]/8;
laplacianImage = imfilter(double(grayImage), laplacianKernel);
% Display the image.
subplot(2, 2, 2);
imshow(laplacianImage, []);
title('Laplacian Image', 'FontSize', fontSize);
 
% Compute the sharpened image, if you have the Laplacian already,
% simply add the original image to the laplacianImage.
sharpenedImage = double(grayImage) + laplacianImage;
% Display the image.
subplot(2, 2, 3);
imshow(sharpenedImage, []);
title('Sharpened Image', 'FontSize', fontSize);
 
% Computer Sobel image
[magnitudeImage, directionImage] = imgradient(grayImage, 'Sobel');
% Display the original gray scale image.
subplot(2, 2, 4);
imshow(magnitudeImage, []);
title('Sobel Image', 'FontSize', fontSize);


kernel = -1 * ones(3);
kernel(2,2) = 8;  % Now kernel = [-1,-1,-1; -1,8,-1; -1,-1,-1]
output = conv2(double(inputImage), kernel, 'same');