close all;
clear all;
clc

j = 0;

%for i = 300
    
    j = j+1;

img   = imread('C:\Users\Guannan\Desktop\spinodal4.png');
img = img(1:300, 1:300);

Fs_x = 0.53;       % pixels per micron
Fs_y = 0.48;

% % We can then compute the pixel sizes in each direction as the reciprocal
% % of the pixel sampling rates:
% 
dx = 1/Fs_x;     % centimeters per pixel
dy = 1/Fs_y;
% 
% % We can then compute a linear distance scale for the X- and Y-axes of
% % the cropped image:
% 
[ M, N, ~ ] = size(img);      % pixels
x = dx*(0:N-1)';               % centimeters
y = dy*(0:M-1)';
% 
% % Next, we compute the frequency increments for both X and Y:
% 
dFx = Fs_x/N;              % cycles per micron
dFy = Fs_y/M;
% 
% % Finally, we can create a frequency domain array for both X and Y:
% 
Fx = (-Fs_x/2:dFx:Fs_x/2-dFx)';     % cycles per centimeter
Fy = (-Fs_y/2:dFy:Fs_y/2-dFy)';

% Use fft2 and fftshift to compute the 2D DFT of the image, and then to 
% display the resulting spectral images using Fx and Fy

% normalize the uneven illumination across the image
se = strel('disk',50);
img1 = imtophat(img,se);

% adjust the image contrast
img2 = img1; %imadjust(img1,stretchlim(img1));

% subtract the mean gray level of the image

meanGrayLevel = mean2(img2); 
imgbg         = double(img2) - meanGrayLevel; 

% show the preprocessed and processed images
figure(1);
subplot(1,2,1);
imshow(img2); colormap(gray); title('raw image');
subplot(1,2,2);
imshow(imgbg); colormap(gray); title('processed image');

% calculate the 2d fft
img2    = fftshift(img2(:,:,1));
F1      = fft2(img2);
F1= 100*log(1+abs(fftshift(F1)));
F1 = mat2gray(F1);
F1 = im2bw(F1, 0.7);

imgbg   = fftshift(imgbg(:,:,1));
F2      = fft2(imgbg);

F2 = 100*log(1+abs(fftshift(F2)));
F2 = mat2gray(F2);
F2 = im2bw(F2, 0.92);

figure(2);
subplot(1,2,1); imagesc(F1); colormap(gray); axis square
title('fft of raw image');
subplot(1,2,2); imagesc(F2); colormap(gray); axis square
title('fft of processed image');

% end