function [sourcepath, outputpath, filename_skel0] =FileIO(taskID, firstframe)
% Copyright(C)
% Filiz Bunyak Ersoy
% University of Missouri-Columbia 
% bunyak@missouri.edu
% & 
% Mingzhai Sun
% Princeton University
% mingzhai@gmail.com

% % % One Unit of taskID = k

% if(taskID==k)
%         sourcepath = fullfile(prefix, 'DZ2', 'Myxo-DZ2-WT-01110703', 'UniformBK', 'output'); 
%         outputpath = fullfile(sourcepath, 'NewMask');
%         filename_skel0 = fullfile(prefix, 'DZ2', 'Myxo-DZ2-WT-01110703', 'UniformBK', 'ManualLabel');
%         firstframeName = sprintf('%04d', firstframe);
%         firstframeName = [firstframeName, '.tif'];
%         filename_skel0 = fullfile(filename_skel0, firstframeName);



prefix = '~/Data/Density/';

if(taskID == 1)
        sourcepath = fullfile(prefix, 'DZ2_1', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_1', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);
        
elseif(taskID == 2)
        sourcepath = fullfile(prefix, 'DZ2_2', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_2', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);
        
        
elseif(taskID == 3)
        sourcepath = fullfile(prefix, 'DZ2_3', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_3', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);


elseif(taskID == 4)
        sourcepath = fullfile(prefix, 'DZ2_4', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_4', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);
        
        
elseif(taskID == 5)
        sourcepath = fullfile(prefix, 'DZ2_5', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_5', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);
        
        
elseif(taskID == 6)
        sourcepath = fullfile(prefix, 'DZ2_6', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_6', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);
        
        
elseif(taskID == 9)
        sourcepath = fullfile(prefix, 'DZ2_9', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_9', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);
        
        
elseif(taskID == 10)
        sourcepath = fullfile(prefix, 'DZ2_10', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_10', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);
        
elseif(taskID == 11)
        sourcepath = fullfile(prefix, 'DZ2_11', 'output'); 
        outputpath = fullfile(sourcepath, 'NewMask');
        filename_skel0 = fullfile(prefix, 'DZ2_11', 'ManualLabel');
        firstframeName = sprintf('%04d', firstframe);
        firstframeName = [firstframeName, '.tif'];
        filename_skel0 = fullfile(filename_skel0, firstframeName);
        
        
end

    

