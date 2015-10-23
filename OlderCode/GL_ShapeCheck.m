% Cell Shape Check 
function [TrackOut] = GL_ShapeCheck(TrackIn)

if nargin == 0
selectpath = uigetdir;
filepath = fullfile(selectpath,'GL_tracklist.mat');
TrackIn = load(filepath);
end


tracklength_threshold = 500; %Min track length
TrackOut = TrackIn; 
savecount = 0;
delcount = 0;
for ii = 1: length(TrackIn.tracklist)
    
    %Check Tracklength
    tracktemp = TrackIn.tracklist(ii);
    tracklength = length(tracktemp.Frameno);
    if tracklength > tracklength_threshold
        centerNodeLen = zeros(1,tracklength);
        
        %Check Track Node Number
        for jj = 1:tracklength
        centerNodeLen(jj) = length(tracktemp.centerNodesList{jj});
        end
        
        if mean(centerNodeLen) >= 5
            savecount = savecount + 1;
        else TrackOut.tracklist(savecount + 1) = [];
           
        end
        
    else TrackOut.tracklist(savecount +1) = [];
    end
    
end

fprintf('Saved %d out of %d \n', savecount, length(TrackIn.tracklist))

end


    
     
