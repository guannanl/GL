%% Fourier Peak Evolution 

%filepath = ['F:\RoyMovies\1.tiff'];
%frames = numel(imfinfo(filepath));
filepath ='/media/guannanl/GL_Passport_2/DK1622_FB/output2.tif';
% fileList = dir(fullfile(filepath, '*.tif'));
% frames = numel(fileList);

startframe = 15000;%18000;          
endframe = 50000;

%%Select ROI
ROIimg = imread(filepath, startframe);
[~, ROI] = imcrop(ROIimg);
%ROI = [xmin, ymin, xsize, ysize];
close all
clear IIII


NUMofLines = 20;
RR = 1:floor(min(ROI(3)/2, ROI(4)/2) - 1);
angle = linspace(  -2*80*pi/180, 2*80*pi/180, NUMofLines);
% angle = linspace( pi/10, 80*pi/180, NUMofLines);
linex = zeros(length(RR),1);
liney = zeros(length(RR),1);
peaks = zeros(endframe - startframe + 1, 1);

intfff = zeros(length(RR), length(angle));
avefff = zeros(length(RR),2);

 Ffig = figure;
 pppfig = figure;
 peakfig = figure;
 
 imgSIZE = round([ROI(4), ROI(3)]);

for ii = [startframe:50:startframe + 500,startframe + 500:500 : endframe] % 1: frames
    fprintf('Frame %d\n', ii)
%img = imread(filepath, ii);
img = imread(filepath, ii);
img = imcrop(img, ROI);

img = img - mean2(img);
img = fftshift(img(:,:));

% Takes Fourier Transform 
 F = fft2(img);
 F = log((1+abs(fftshift(F))).^2);
 F = mat2gray(F);
 
 F = im2bw(F, 0.72);
 F = smooth2a(F, 3);

 
 Ffig;
 imagesc(F); colormap(gray); axis square
 hold off
 

for iii = 1: length(angle)
    linex = ceil(RR.*cos(angle(iii)) + imgSIZE(1)/2);
    liney = ceil(RR.*sin(angle(iii)) + imgSIZE(2)/2);
    for jj = 1:length(RR)
        intfff(jj, iii) = F(linex(jj), liney(jj));
    end
end
 
 
 for aa = 1:length(RR)
    avefff(aa,1) = mean(intfff(aa,:));
    avefff(aa,2) = std(intfff(aa,:));
 end

 % Now fit Peaks
 
 fitfit = fit((5:length(RR)).', avefff(5:end,1), 'gauss1');
 peaks(ii - startframe + 1) = fitfit.b1;
 
 peakfig;
 plot (RR, avefff(:,1), 'o')
 hold off
 
end

peaks = 1./peaks;
% peaks = GL_RunAve(peaks, 5);
peaks = peaks.*1500;
time = (1:endframe - startframe + 1)';
pppfig;
loglog(time, peaks, '-s')


 