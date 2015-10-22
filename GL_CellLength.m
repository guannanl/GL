%% Cell Length 
% Calculate the Cell Long Axis in unit of um. 
% Guannan Liu
function [TrackOut] = GL_CellLength(TrackIn)

if nargin == 0
selectpath = uigetdir;
filepath = fullfile(selectpath,'tracklist.mat');
TrackIn = load(filepath);
end

%filepath = ['C:\Users\Guannan\Desktop\Density_result\DZ2_1\tracklist.mat'];

TrackOut = TrackIn;

PixelSizeX = 82/1000; %um
PixelSizeY = 81/1000; %um

trackno = length(TrackIn.tracklist);
track = TrackIn.tracklist;

for ii = 1:trackno
    
    temptrack = track(1, ii);
    tracklength = length(temptrack.Frameno);
    TrackOut.tracklist(1, ii).CellLen = zeros(tracklength, 1);
    
    
    for jj = 1:tracklength
        
        X1 = temptrack.BB(jj, 1)*PixelSizeX;
        Y1 = temptrack.BB(jj, 2)*PixelSizeY;
        X2 = temptrack.BB(jj, 3)*PixelSizeX;
        Y2 = temptrack.BB(jj, 4)*PixelSizeY;
        
        TrackOut.tracklist(1, ii).CellLen(jj, 1) = max((X2 - X1), (Y2 - Y1));
        
    end
end

end

    
    
