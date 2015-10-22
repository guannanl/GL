
%This function is used to stitch images together. The images are acquired
%with the corresponding Labview program. 
%The sequence of the images are the followings:
% 7 6 5
% 8 1 4
% 9 2 3
%The center tile is 1 and the left bottom corner is 9. 
%Usage:
% stitchImages(pxl_x, pxl_y, overlap_x, overlap_y)
%For exmample
% stitchImages(85, 86, 36550, 36550)
%pxl_x: pixel size along the x direction. Default is 85
%pxl_y: pixel size along the y direction. Default is 86. 
%overlap_x: the overlap used in the image acquization along the x
%direction. 
%overlap_y: the overlap used in teh image acquization along the y
%direction. 
%Overlap_x and overlap_y are 36550 nm used in the Labviw program. 
%
%
% Copyright(C)
% Filiz Bunyak Ersoy
% University of Missouri-Columbia 
% bunyak@missouri.edu
% & 
% Mingzhai Sun
% Princeton University
% mingzhai@gmail.com
%

    %if(nargin==0)
%         pxl_x = 85;
%         pxl_y = 86;
        pxl_x = 82;
        pxl_y = 81;
        overlap_x = 36550; 
        overlap_y = 36550;
    %end
    
    dirName = ['C:\Users\Guannan\Desktop\Stitch_test\'];
    fileList = dir(fullfile(dirName, '*.tif'));
    frames = numel(fileList);
    frames = frames/9;
    filePref = fileList(1).name(1:end-14);%works only for the particular file name rules

   
    
    
    %ask the user to select background for each tiles
    ROIList = [];
    for i=0:8
        prestr = sprintf('%04d', i+1);
        filePre = [filePref, prestr];
        
        imName = [filePre, '_', num2str(i), '_DIC.tif'];
%         imName = [filePre, '_', num2str(i), '_Red.tif'];
        im = imread(fullfile(dirName, imName));
        figure, imagesc(im);
        [dummy, rect] = imcrop;
        temp.rect = rect;
        ROIList = cat(1, ROIList, temp);
    end
    
    close all;
    
    %numCores = feature('Numcores');
    %matlabpool('open', numCores);
    for i=0:(frames-1)
        prestr = sprintf('%04d', i+1);
        filePre = [filePref, prestr];
        %could use a loop, but I like this better.
        f1 = [filePre, '_0_DIC.tif'];
        f2 = [filePre, '_1_DIC.tif'];
        f3 = [filePre, '_2_DIC.tif'];
        f4 = [filePre, '_3_DIC.tif'];
        f5 = [filePre, '_4_DIC.tif'];
        f6 = [filePre, '_5_DIC.tif'];
        f7 = [filePre, '_6_DIC.tif'];
        f8 = [filePre, '_7_DIC.tif'];
        f9 = [filePre, '_8_DIC.tif'];
%         f1 = [filePre, '_0_Red.tif'];
%         f2 = [filePre, '_1_Red.tif'];
%         f3 = [filePre, '_2_Red.tif'];
%         f4 = [filePre, '_3_Red.tif'];
%         f5 = [filePre, '_4_Red.tif'];
%         f6 = [filePre, '_5_Red.tif'];
%         f7 = [filePre, '_6_Red.tif'];
%         f8 = [filePre, '_7_Red.tif'];
%         f9 = [filePre, '_8_Red.tif'];
        
        im1 = double(imread(fullfile(dirName, f1)));
        im2 = double(imread(fullfile(dirName, f2)));
        im3 = double(imread(fullfile(dirName, f3)));
        im4 = double(imread(fullfile(dirName, f4)));
        im5 = double(imread(fullfile(dirName, f5)));
        im6 = double(imread(fullfile(dirName, f6)));
        im7 = double(imread(fullfile(dirName, f7)));
        im8 = double(imread(fullfile(dirName, f8)));
        im9 = double(imread(fullfile(dirName, f9)));
        
        temp1 = imcrop(im1, ROIList(1).rect);
        im1_mean = mean(temp1(:));
        
        temp2 = imcrop(im2, ROIList(2).rect);
        im2_mean = mean(temp2(:));
        
        temp3 = imcrop(im3, ROIList(3).rect);
        im3_mean = mean(temp3(:));
            
        temp4 = imcrop(im4, ROIList(4).rect);
        im4_mean = mean(temp4(:));
        
        temp5 = imcrop(im5, ROIList(5).rect);
        im5_mean = mean(temp5(:));
          
        temp6 = imcrop(im6, ROIList(6).rect);
        im6_mean = mean(temp6(:));
        
        temp7 = imcrop(im7, ROIList(7).rect);
        im7_mean = mean(temp7(:));
        
        temp8 = imcrop(im8, ROIList(8).rect);
        im8_mean = mean(temp8(:));
        
        temp9 = imcrop(im9, ROIList(9).rect);
        im9_mean = mean(temp9(:));
        
        im2 = im2/im2_mean*im1_mean;
        im3 = im3/im3_mean*im1_mean;
        im4 = im4/im4_mean*im1_mean;
        im5 = im5/im5_mean*im1_mean;
        im6 = im6/im6_mean*im1_mean;
        im7 = im7/im7_mean*im1_mean;
        im8 = im8/im8_mean*im1_mean;
        im9 = im9/im9_mean*im1_mean;
        
%         im2 = im2/im2_mean;
%         im3 = im3/im3_mean;
%         im4 = im4/im4_mean;
%         im5 = im5/im5_mean;
%         im6 = im6/im6_mean;
%         im7 = im7/im7_mean;
%         im8 = im8/im8_mean;
%         im9 = im9/im9_mean;
        %there are good
        % 7 6 5
        % 8 1 4
        % 9 2 3
        offx = round(512 - overlap_x/pxl_x); 
        offy = round(512 - overlap_y/pxl_y);
        im765 = [im7, im6(:, offx:512), im5(:, offx:512)];
        im814 = [im8, im1(:, offx:512), im4(:, offx:512)];
        im923 = [im9, im2(:, offx:512), im3(:, offx:512)];
        
        %the reason to use the circshift is because there is a shift in the
        %y direction, which is about 3 pixels. The reason for the shift is
        %not clear. It is due to the data acquization. 
        res = [im765; circshift(im814(offy:512, :), [0, 3]); ...
            circshift(im923(offy:512, :), [0, 6])];
        res = mat2gray(res);
        
        %write the data to the "./output" directory.
        if(~isdir(fullfile(dirName, './output')))
            mkdir(fullfile(dirName, './output'));
        end
        
        outName = [prestr, '.tif'];
        imwrite(res, fullfile(dirName, './output/', outName));
        if(mod(i, 10) == 0)
            fprintf('%s%d%s%d\n', 'Now working on: ', i, '  out of: ', (frames-1));
        end
        
    end
    %matlabpool('close');
    

