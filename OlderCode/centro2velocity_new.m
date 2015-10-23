function [FileOut] = centro2velocity_new(FileIn)

%% Velocity Calculation from centroid position
% Guannan Liu:
% This function uses the centroids position in the track to recalibrate the velocity. 
% Input should be the directory location of tracklist.mat
% Output is another struct with a new field: FileOut.tracklist.Velocity


%Get tracklist.mat
if nargin == 0
selectpath = uigetdir;
% filepath = fullfile(selectpath,'tracklist.mat');
filepath = fullfile(selectpath,'SMtracklist1');
FileIn = load(filepath);
end

%filepath = ['C:\Users\Guannan\Desktop\Density_result\DZ2_1\tracklist.mat'];

FileOut = FileIn;

FrameRate = 10/60; %min
PixelSizeX = 82/1000; %um
PixelSizeY = 81/1000; %um

trackno = length(FileIn.tracklist);

%Load each track 
for ii = 1: trackno
    track = FileIn.tracklist(1, ii);
    tracklength = length(track.Frameno);
    
    centro_x = track.Centroid(:,1);
    centro_y = track.Centroid(:,2);
    
    velocity_x = GL_GDER(centro_x, 1, 50).*PixelSizeX.*FrameRate;
    velocity_y = GL_GDER(centro_y, 1, 50).*PixelSizeX.*FrameRate;

    FileOut.tracklist(1,ii).Velocity = [velocity_x, velocity_y];
end

end
    
    
    
   



