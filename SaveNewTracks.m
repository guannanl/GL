%% Save New tracklist.mat file
for ii = 1%[1,2,3,4,5,6,8,9,10,11]
    
    fprintf('Now working on track #%d \n', ii)
    
    inpath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',ii),'\tracklist.mat'];
    outpath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',ii),'\GL_tracklist_new.mat'];
        
    track = load(inpath);
%1. Calculate new velocity from centroid positions
    track = centro2velocity(track);

%2. Add the CellLen field
    track = GL_CellLength(track);

%3. Calculate the Neighbor field 
    track = GL_LocalDensity(track, 10);

%4. Calculate Reversals 
    track = GL_reversal(track);

%5. Save New .mat files 
    tracklist = track.tracklist;
    save(outpath, 'tracklist');

end