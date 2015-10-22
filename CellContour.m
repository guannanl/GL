%% Construct Contour of Cells from 
filepath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',1),'\GL_tracklist_shape.mat'];
track = load(filepath);
track = track.tracklist;

trackno = length(track);
cellfig = figure;

for i = 1: trackno
    tracktemp = track(i);
    for j = 1:length(tracktemp.Frameno);
        frame = tracktemp.Frameno(1) + j - 1;
        list = tracktemp.centerNodesList
        
        
        
        
        
    
    end
end
    
    
