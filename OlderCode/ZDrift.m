%% Z Drift Ruler

filepath = ['F:\Zdrift\0001\'];
fileList = dir(fullfile(filepath, '*.tif'));
frames = numel(fileList);

%% ROI Selection 




for ii = 1:frames
    