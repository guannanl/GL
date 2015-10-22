%% Simply Stitch

    dirName = ['C:\Users\Guannan\Desktop\Stitch_test\UniformBK\'];
    fileList = dir(fullfile(dirName, '*.tif'));
    frames = numel(fileList);
    frames = frames/9;
    
    output_path = ['C:\Users\Guannan\Desktop\Stitch_test\UniformBK\output\'];
    
    if (~isdir(output_path))
        mkdir(output_path)
    end
    
    
    for jj = 1:10
        
    
    pre_file = ['Grid_20140910_145509_', sprintf('%04d',jj )];
    
    
    for ii = 0:8
       
        temp_str = sprintf('_%01d',ii);
        temp_filepath = [dirName, pre_file, temp_str,'_DIC.tif'];
        
        tiff_name = sprintf('%04d', ii);
        temp_tiff_name = genvarname(['tiff_', tiff_name]);
        execuation_line = sprintf('= imread(temp_filepath)');
        eval([temp_tiff_name, execuation_line,';']);
        
        
    end
    
    line1 = [tiff_0004, tiff_0003, tiff_0002];
    line2 = [tiff_0005, tiff_0000, tiff_0001];
    line3 = [tiff_0006, tiff_0007, tiff_0008];
    
    %res = [line1;line2;line3];
    
    res = [line1; circshift(line2(:, :), [0, 3]); ...
            circshift(line3(:, :), [0, 6])];
        res = mat2gray(res);
    
    %imshow(res, []);
    
    outfile = [output_path, pre_file, '.tif'];
    
   
    imwrite(res, outfile);
    
    
 
    end 
    
    