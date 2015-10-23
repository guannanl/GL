%% Get Reversals 
function [FileOut] = GL_reversal(FileIn)
%Get reversal events. 
%Input should be a load.tracklist file. 
%Output file is a load.tracklist file, with a new field: load.tracklist.reversal.
%Guannan Liu

if nargin == 0
selectpath = uigetdir;
filepath = fullfile(selectpath,'tracklist.mat');
FileIn = load(filepath);
end

%Recalculate .Velocity Field from Centroid Positions
%FileIn = centro2velocity(FileIn);
FileOut = FileIn;

%FrameRate = 10/60; %min

%Load the track%
track = FileIn.tracklist;
trackno = length(FileIn.tracklist);

for ii = 1:trackno
    
    tracktemp = track(1,ii);
    
    tracklength = length(tracktemp.Frameno);
    velocity_x = tracktemp.Velocity(:,1);
    velocity_y = tracktemp.Velocity(:,2);
    
    reversal = zeros(tracklength,1);
    
    if tracklength > 50 %Threshold for tracklength 

        %Check reversal for each frame
        for jj = 2:tracklength

          %  conditionV = (velocity_x(jj).*velocity_x(jj - 1) + velocity_y(jj).*velocity_y(jj - 1)); 
           
          if  (((velocity_x(jj-1) < 0 && velocity_x(jj) > 0)||(velocity_x(jj-1) > 0 && velocity_x(jj) < 0)||velocity_x(jj) == 0) ...
                || ((velocity_y(jj-1) < 0 && velocity_y(jj) > 0)||(velocity_y(jj-1) > 0 && velocity_y(jj) < 0)||velocity_y(jj) == 0))
            

%             if(conditionV<=0)
                 reversal(jj) = 1; 
            else reversal(jj) = 0;
            end
        end
        
    end 
   
    FileOut.tracklist(1,ii).reversal = reversal;
end

end

    
    
    
