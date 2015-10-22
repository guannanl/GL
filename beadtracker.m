%% Load parameters
clear all; close all;
filepath = ['C:\Users\Guannan\Desktop\Bead movement_2_OD0.344.tif'];
outpath = ['C:\Users\Guannan\Desktop\BeadCen.mat'];
imageinfo = imfinfo(filepath);
frameno = numel(imageinfo);
fig = figure;
 intens = figure;
%% Loop Begin
for ii = 1: frameno
    %% Load Image and DeNoise
    imtemp = imread(filepath, ii);
    imtemp = mat2gray(imtemp);
    imtemp = DeNoise(double(imtemp), 2);
    
    %% Use this intensity plot to figure out the threshold
%         [x,y]=size(imtemp);
%         X=1:x;
%         Y=1:y;
%         [xx,yy]=meshgrid(Y,X);
%         i=im2double(imtemp);
%         figure;mesh(xx,yy,i);
%         colorbar off
%         pause (1)
    %% BW Thresholding
    beadthresh = 0.68;
    imbw = imtemp > beadthresh;
    Centemp = regionprops(imbw, 'Centroid');
    
    beadCen.(sprintf('frame%03d', ii)) = Centemp;
    
    %% Plot bead vs outline
    figure(fig)
    
    subplot(2,1,1)
    imagesc(imtemp)
    axis off
    hold on
    viscircles(Centemp.Centroid, 5, 'LineStyle', '--');
    axis off
    hold off
    
    subplot(2,1,2)
    imagesc(imbw)
    axis off
    hold on
    viscircles(Centemp.Centroid, 5,'EdgeColor','b', 'LineStyle', ':');
    axis off
    hold off
    
    pause(1)
    
    
end


%% Save Data
 save(outpath, 'beadCen');
