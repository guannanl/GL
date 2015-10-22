% Check Density in each frame
    readfile_ST
    frames = orderedDataSet(:,1);
    uniq_frames = unique(orderedDataSet(:,1));
    density = [];
    
    for ii = 1: length(uniq_frames)
     
        x = find(frames == uniq_frames(ii,1));
        temp = length(x);
        density = [density; temp];
            
    end 
    
%     plot(uniq_frames, density)   
%     Clear the Data a little before plotting... 

plotter = [uniq_frames, density];
temp  = [];

    for jj = 1: length(plotter)
        
        if plotter(jj, 2) < 55
            temp = [temp;jj];
        end
        
    end
    
    plotter(temp, :) = [];
    plot(plotter(:,1),plotter(:,2))
    
   
   
    
    
    