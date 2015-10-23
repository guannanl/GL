%% Mean Square Displacement Calcualtion
% Guannan Liu

function [TrackOut] = GL_MSD(TrackIn, tracklength_threshold)

if nargin == 0
selectpath = uigetdir;
filepath = fullfile(selectpath,'tracklist.mat');
TrackIn = load(filepath);
tracklength_threshold = 50; %Min track length
end

%FrameRate = 10/60; %min

TrackOut = TrackIn;

trackno = length(TrackIn.tracklist);
track = TrackIn.tracklist;

for ii = 1:trackno
    
    tracktemp = track(ii);
    tracklength = length(tracktemp.Frameno);
    
    if tracklength >= tracklength_threshold;
        Trajectory = tracktemp.Centroid ;%, tracktemp.Frameno];
        %[msd, tau]  = Kehl(Trajectory);
        [msd, tau]  = ST_MSD(Trajectory);
        TrackOut.tracklist(ii).MSD = zeros(length(msd),2);
        TrackOut.tracklist(ii).MSD(:,1) = msd(:);
        TrackOut.tracklist(ii).MSD(:,2) = tau(:); 
    else
        TrackOut.tracklist(ii).MSD = -ones(tracklength,2);
    end
    
end

end
