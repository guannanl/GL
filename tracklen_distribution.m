function [tracklength] = tracklen_distribution(track)
%% Get the Track Length Distribution
% Guannan Liu

if nargin == 0
selectpath = uigetdir;
filepath = fullfile(selectpath,'tracklist.mat');
track = load(filepath);
end

trackno = length(track.tracklist);
tracklength = [];

for ii = 1:trackno
    tracktemp = track.tracklist(1,ii);
    tracklengthtemp = length(tracktemp.Frameno);
    
    tracklength = [tracklength;tracklengthtemp];
end


