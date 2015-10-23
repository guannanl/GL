%% Local Density/Neighbor Check
%Dist_threshold is in um units
function [TrackOut] = GL_LocalDensity(TrackIn, Dist_threshold)

if nargin == 0
selectpath = uigetdir;
filepath = fullfile(selectpath,'tracklist.mat');
TrackIn = load(filepath);
Dist_threshold = 30; %in pixel units
end
Dist_threshold = Dist_threshold/0.08;
Tracklength_threshold = 50; %min length of a track to be called a track 
CellLength_threshold = 2; %um

%filepath = ['C:\Users\Guannan\Desktop\Density_result\DZ2_1\tracklist.mat'];

TrackOut = TrackIn;

% FrameRate = 10/60;    %min
% PixelSizeX = 82/1000; %um
% PixelSizeY = 81/1000; %um

trackno = length(TrackIn.tracklist);
track = TrackIn.tracklist;

%Count near Neighbors 
for ii = 1:trackno
    fprintf('Now Working on Cell #%d, Out of %d\n', ii, trackno);
    tracktemp = track(1, ii);
    tracklength = length(tracktemp.Frameno);
    %startframe = tracktemp.start_frame;
    CellLenth = mean(tracktemp.CellLen(:));
    
    if (CellLenth > CellLength_threshold) ... 
            && (tracklength > Tracklength_threshold); %Threshold on cell length and track length    
        
        TrackOut.tracklist(1, ii).neighbor = zeros(tracklength, 1);
        
        for jj = 1: tracklength

            currentframe = tracktemp.Frameno(jj, 1);
            currentCentroidX = tracktemp.Centroid(jj, 1);
            currentCentroidY = tracktemp.Centroid(jj, 2);

            for iii = 1:trackno
                if (iii ~= ii) ... %not current cell
                  if (mean(track(1, iii).CellLen(:)) > CellLength_threshold)  % Neighbor Cell length check
                   if (length(track(1, iii).Frameno) > Tracklength_threshold) % Neighbor Track length check 
                    if(ismember(currentframe, track(1, iii).Frameno))
                        
                    ind = (find(currentframe == track(1, iii).Frameno));
                    %tempframe = track(1, iii).Frameno(ind, 1);
                    tempCentroidX = track(1, iii).Centroid(ind, 1);
                    tempCentroidY = track(1, iii).Centroid(ind, 2);

                    %distance in pixel units 
                    DIST = sqrt((tempCentroidX - currentCentroidX)^2 + (tempCentroidY - currentCentroidY)^2);

                    if DIST <= Dist_threshold
                        TrackOut.tracklist(1, ii).neighbor(jj, 1) = TrackOut.tracklist(1, ii).neighbor(jj, 1) + 1;
                    end

                    end;end;end;end
                
            end
        end
        
    else 
        
        TrackOut.tracklist(1, ii).neighbor = -ones(tracklength, 1);
    
    end
    

end

end
