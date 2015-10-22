clear;
clc;
tic



for loop1 = 3:2:5
    %     plotnum = 0;
    %     for loop2end = 1
    %         plotnum= plotnum+1;
    visits = zeros(1364,1374);
    for loop2 = 0:1199
        %
        textin1 = ['MASKS/00',num2str(loop1),'/mask_' sprintf('%.4d',loop2),'.png'];
        textin2 = ['MASKS/00',num2str(loop1),'/mask_' sprintf('%.4d',loop2+1),'.png'];
        I1 = imread(textin1);
        I2 = imread(textin2);
        I1 = im2bw(I1,0.0002);
        I2 = im2bw(I2,0.0002);
        
        Ixor = xor(I1,I2);
        %         ini  = ini + Ixor;
        visits = visits + Ixor;
        %         figure; imshow(Ixor);
        %         pixelV(loop1,loop2) = sum(sum(Ixor));
        
        %         plot(pixelV(loop1,:));
        
        %         hold on;
        
    end
    
    for ii=1:1364
        for jj=1:1374
            if visits(ii,jj) > 100
                if visits(ii,jj)>200
                    visits(ii,jj)=visits(ii,jj)-150;
                else
                    visits(ii,jj) = visits(ii,jj)-75;
                    
                end
                end
            end
        end
        figure;
        %         subplot(3,3,loop1);
        imagesc(visits); axis square;
                colormap('hot');
        caxis([0 300])
    end
    % end
