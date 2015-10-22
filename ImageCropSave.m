%% Image Crop Save

filepath ='/media/guannanl/GL_Passport_2/DK1622_FB/29/';
outpath = '/media/guannanl/GL_Passport_2/DK1622_FB/output2.tif';
fileList = dir(fullfile(filepath, '*.tif'));
frames = numel(fileList);


startframe = 22000;

endframe = 99760; 

%Select ROI
ROIimg = imread(fullfile(filepath, fileList(startframe).name));
[IIII, ROI] = imcrop(ROIimg);



for ii = startframe: endframe % 1: frames
    fprintf('Frame %d\n', ii)
%img = imread(filepath, ii);
img = imread(fullfile(filepath, fileList(ii).name));
img = imcrop(img, ROI);

img = img - mean2(img);
img = mat2gray(img);
if ii == startframe
    imwrite(img,outpath);
else
    imwrite(img,outpath,'WriteMode','append');
end
fprintf('Now saving img %d', ii);
end

