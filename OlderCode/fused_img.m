%% Overlay Test

prefile = ['E:\Shaevitz_OT\Ecoli_Myxo\10022014\Trial_6\'];

DIC_path = [prefile, 'DIC\'];
GREEN_path = [prefile, 'GREEN\'];

outpath = [prefile, 'fused_imgs\'];

for ii = 1: 1000
    
    index = sprintf('%04d', ii);
    
    DIC = [DIC_path, index,'.tif'];
    GRE = [GREEN_path, index, '.tif'];
    
    DIC_img = imread(DIC);
    GREEN_img = imread(GRE);
    
    %img = imfuse(DIC_img, GREEN_img, 'Scaling', 'none', 'ColorChannels', [2,1,2]);
    
    
    DIC_img = double(DIC_img);
    GREEN_img = double(GREEN_img);
    
    % img = zeros([size(DIC_img),3]);
    
    R = 2.5*DIC_img;
    G = 2.2*DIC_img + GREEN_img ;
    B = 2.5*DIC_img;
    
    
    
    R = R/max(R(:));
    G = G/max(G(:));
    B = B/max(B(:));
    
    
    img = cat(3,R, G, B);
    
    
    
    outname = [outpath, index, '.tif'];
    
    %      imshow(img,[])
    %      pause(0.5)
    
    imwrite(img, outname);
end
