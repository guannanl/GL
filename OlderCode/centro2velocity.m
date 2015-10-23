function [FileOut] = centro2velocity(FileIn)

%% Velocity Calculation from centroid position
% Guannan Liu:
% This function uses the centroids position in the track to recalibrate the velocity. 
% Input should be the directory location of tracklist.mat
% Output is another struct with a new field: FileOut.tracklist.Velocity


%Get tracklist.mat
if nargin == 0
selectpath = uigetdir;
filepath = fullfile(selectpath,'tracklist.mat');
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
    
    displaceX = centro_x - [centro_x(1,1); centro_x([1:tracklength-1],1)];
    displaceY = centro_y - [centro_y(1,1); centro_y([1:tracklength-1],1)];
    
    velocity_x = zeros(tracklength, 1);
    velocity_y = zeros(tracklength, 1);
    
    pixelthresh = 1; %What is defined as a movement?????? Threshhold = ** pixels????
    
    for jj = 1:tracklength
    
        if abs(displaceX(jj)) > pixelthresh
            velocity_x(jj) = displaceX(jj).*PixelSizeX./FrameRate;
        end
    
        if abs(displaceY(jj)) > pixelthresh
            velocity_y(jj) = displaceY(jj).*PixelSizeY./FrameRate;
        end
    
    end
    
    
    
    
    FileOut.tracklist(1,ii).Velocity = [velocity_x, velocity_y];
end

end
    
    
    
   



