%% GL DeNoise
close all
image = imread(['C:\Users\Guannan\Desktop\test.tif']);

% figure
% imagesc(image)


L = medfilt2(image,[7 7]);
figure, imshow(L)


WSize = 500;
N = floor(WSize/2);
sig = N/2.5;
[x,y] = meshgrid(-N:N, -N:N);
G = exp(-(x.^2+y.^2)/(2*sig^2))/(2*pi*sig);
Gx = -x.*G/(sig^2);Gx = Gx/sum(Gx(:));
Gy = -y.*G/(sig^2);Gy = Gy/sum(Gy(:));
Rx = imfilter(double(L), Gx, 'conv', 'replicate');
Ry = imfilter(double(L), Gy, 'conv', 'replicate');
FM = sqrt(Rx.^2+Ry.^2);
figure, imshow(FM, [])