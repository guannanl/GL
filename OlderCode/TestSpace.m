% % % 
% % % close all;
% % % % trackIn = load('D:\Desktop_temp\Density_result\DZ2_11\GL_tracklist.mat');
% % % ini = 1;
% % %  %overallIndex = overallIndex+1;
% % %     en1 = ini+300;
% % % minlen = 300;
% % % indexfrz = 0;
% % % indexdz = 0;
% % % % en1 = 800;
% % % refslp = 1;
% % % refmag = 1;
% % % % ini = 599;
% % % msdsstorefrz = zeros(en1-ini-1,3);
% % % msdsstoredz2 = zeros(en1-ini-1,3);
% % % for loop1 = 1
% % %     loadtext = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',loop1),'\GL_tracklist.mat'];
% % %    % loadtext = ['D:\Desktop_temp\trackingData\DZ2\', sprintf('SMtracklist%d.mat', loop1)];
% % %     a1 = load(loadtext);
% % %     b1 = a1.tracklist(1,1:length(a1.tracklist));
% % %     for n = 1:length(b1);
% % %         b1(:,n).TrackL = mean(b1(:,n).TrackLen);
% % %     end
% % %     C1 = nestedSortStruct(b1, 'TrackL');
% % %     
% % %     for i = 1:length(C1);
% % %         r1(1,i) = C1(1,i).TrackL;
% % %     end
% % %     
% % %     ind1 = find (r1 > minlen);
% % %     
% % %     index1 = 0;
% % %     
% % %     
% % %     for k1= min(ind1):max(ind1)
% % %         
% % %         index1 = index1 +1;
% % %         
% % %         centro     = C1(1,k1).Centroid;
% % %         vel        = C1(1,k1).Centroid;
% % %         X1 = centro(ini+1:en1,1);
% % %         Y1 = centro(ini+1:en1,2);
% % %         
% % %         X2     = X1(1:(end-1));
% % %         
% % %         X3     = (diag(X2')*hankel(ones(1,length(X2))))';
% % %         X4     = hankel(X1(2:end));
% % %         
% % %         Y2     = Y1(1:(end-1));
% % %         
% % %         Y3     = (diag(Y2')*hankel(ones(1,length(Y2))))';
% % %         Y4     = hankel(Y1(2:end));
% % %         
% % %         msdsx  = ((X4 - X3));
% % %         msdsy  = ((Y4 - Y3));
% % %         
% % %         msds   = (msdsx.^2 + msdsy.^2);
% % %         
% % %         factor = (size(msds)):-1:1;
% % %         msdsav2 = ones(1,length(msds))*(msds');
% % %         msdsav3 = msdsav2./factor;
% % %         time   = 1:(size(msds));
% % %         time = time/6;
% % %         
% % %         msdsav = msdsav3';
% % %         
% % %         ss = polyfit(log(time(1,1:30)),log(msdsav3(1,1:30)),1);
% % %         slp = ss(1);
% % %         
% % %         if (slp > refslp && msdsav(1,1) > refmag)
% % %             
% % %            % slp;
% % %             msdsstoredz2(:,index1) = msdsav;
% % % %             figure(1); loglog(time,msdsav3,'b'); hold on;
% % %             indexdz = indexdz + index1;
% % %             
% % %         else
% % %             continue
% % %         end
% % %         
% % %     end
% % %     
% % %     msdsmeanplotDZ2(:,loop1) = mean(msdsstoredz2,2);
% % %     clear a1;
% % %     clear b1;
% % %     clear C1;
% % %     clear r1;
% % %     clear ind1;
% % %    
% % %     
% % %     
% % % end
% % % 
% % %   msdsDZ2 = mean(msdsmeanplotDZ2,2);
% % %     loglog(time,(msdsDZ2*(0.085^2)),'-s')
% % 
% % 
% % 
% % 
% % 
% % % 
% % % 
% % % %MSDplot = figure;
% % % figcount = 0;
% % % for ii = [1,2,3,4,5,6,8,9,10,11]
% % %     
% % %     disp(sprintf('Now working on track %d', ii));
% % %     
% % %     figcount = figcount +1; 
% % % %     
% % % %   filepath = ['D:\Desktop_temp\trackingData\DZ2\', sprintf('SMtracklist%d.mat', ii)];
% % % %   filepath = ['D:\Desktop_temp\trackingData\frzE\', sprintf('00%dSMtracklist.mat', expID)];
% % %     filepath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',ii),'\GL_tracklist.mat'];
% % %     trackIn = load(filepath);
% % %     [MSD, TAU] = ST_MSD(trackIn, 150);
% % %     
% % %     figure %(MSDplot)
% % %     %subplot (3, 4, figcount);
% % %     loglog(TAU,MSD, '-s')
% % %     title(sprintf('MSD vs Time (Exp#%d)',ii),'FontSize', 10)
% % %     xlabel('Time (min)','FontSize', 10)
% % %     ylabel('MSD(\mum^2)','FontSize', 10)
% % %     
% % % end
% % % 
% % % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % for ii = [1,2,3,4,5,6,8,9,10,11]
% %     
% %     fprintf('Now working on track #%d \n', ii)
% %     
% %     inpath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',ii),'\GL_tracklist.mat'];
% %     outpath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',ii),'\GL_tracklist_shape.mat'];
% %         
% %     track = load(inpath);
% % % %1. Calculate new velocity from centroid positions
% % %     track = centro2velocity(track);
% % % 
% % % %2. Add the CellLen field
% % %     track = GL_CellLength(track);
% % % 
% % % %3. Calculate the Neighbor field 
% % %     track = GL_LocalDensity_new(track, 10);
% % % 
% % % %4. Calculate Reversals 
% % %     track = GL_reversal(track);
% % track = GL_ShapeCheck(track);
% % 
% % %5. Save New .mat files 
% %     tracklist = track.tracklist;
% %     save(outpath, 'tracklist');
% % 
% % end
% % 
% % 
% 
% % A = [];
% % 
% % 
% % for ii = [1,2,3,4,5,6,8,9,10,11]
% %     
% %     fprintf('Now working on track #%d \n', ii)
% %     
% %     inpath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',ii),'\GL_tracklist_shape.mat'];
% %     %outpath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',ii),'\GL_tracklist_shape.mat'];
% %      
% %     A.(sprintf('track%04d', ii)) = load(inpath);
% % end
% % 
% % 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % clear all;
% % x = [-60:60]*(1/2000);
% % y = x;
% % 
% % 
% % x1 = [0:4];
% % y1 = x1;
% % 
% % img = imread('C:\Users\Guannan\Desktop\spinodal5.png');
% % % img = imread('C:\Users\Guannan\Desktop\Capture.png');
% % 
% % 
% % img = img(1:500,1:500);
% % % pixel = 10um;
% % img = img - mean2(img);
% % %% lll
% %     figure
% %     imagesc(x1, y1, img); colormap(gray); axis square
% % title(sprintf('Fruiting Body Formation Image'), 'FontSize', 20)
% %     ylabel('Y(mm)','FontSize', 15)
% %     xlabel('X(mm)','FontSize', 15)
% % %% llll    
% % %img   = fftshift(img(:,:));
% % F     = fft2(img);
% % %F = log(1+abs(fftshift(F)));
% % F=log((1+abs(fftshift(F))).^2);
% % F = mat2gray(F);
% % imagesc(F)
% % 
% % F = im2bw(F, 0.73);
% % 
% % F = smooth2a(F, 5);
% % figure
% % imagesc(x,y,F(190:310, 190:310)); colormap(gray); axis square
% % title(sprintf('Fourier Transform Magnitude Spectrum'), 'FontSize', 20)
% %      ylabel('Y(1/\mum)','FontSize', 15)
% %      xlabel('X(1/\mum)','FontSize', 15)
% %    
% % %x, y, 
% % 
% % % figure;
% % % imagesc(angle(F));  colormap(gray);
% % % title('phase spectrum');
% % % 
% % % 
% % % 
% % % figure;
% % % for ii = 250:255
% % %     plot(F(ii,:), 'b');hold on
% % % end
% % % 
% % 
% % linex = [1:100] + 250;
% % pointy = [1,100;10,90; 20, 80; 30,70; 40, 60; 50, 50]; 
% % angle = zeros(length(pointy(:,1)),1);
% % for ii = 1:length(pointy(:,1));
% % angle(ii) = atan((pointy(ii,2))/(pointy(ii,1)));
% % liney = round([1:100].*angle(ii) + 250);    
% % for jj = 1:100
% % intfff(jj, ii) = F(linex(jj), liney(jj));
% % end
% % 
% % end
% % 
% % avefff = zeros(100,2);
% % for iii = 1:100
% %     
% %     ave(iii,1) = mean(intfff(iii,:));
% %     ave(iii,2) = std(intfff(iii,:))/3;
% %     
% % % end
% % 
% % figure
% % errorbar([1:30]/1000, ave(1:30,1), ave(1:30,2), ...
% %                               'ko',...
% %                                'Linewidth',1.5,...
% %                                'MarkerEdgeColor','k',...
% %                                'MarkerFaceColor','r',...
% %                                'MarkerSize',5);
% % xlabel('Length(1/\mum)', 'FontSize', 20)
% % ylabel('Fourier Transform Magnitude', 'FontSize', 20)
% % hold on
% % 
% % peaks = ave(1:30,1);
% % 
% % x = [0:0.01:45]/1500;
% % a1 =      0.3124 ;
% %        b1 =        7.61/1000 
% %        c1 =       9.246 /1000;
% % y =  a1.*exp(-((x-b1)./c1).^2);       
% % 
% % plot(x,y, 'b', 'Linewidth', 1)
% % hold off
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 
% % % 
% % tif = imread('D:\Dropbox\My_Docs\APS_Myxo_GL\FluoDensity.tif');
% % tif = double(flipud(tif(:,:)));
% % tif = smooth2a(tif,5);
% % tif = tif./max(max(tif));
% % tif = tif- mean2(tif);
% % x = 0:1:7;
% % y = 0:1:5;
% % imagesc(x,y,tif); colormap(jet); c = colorbar; %axis square
% % title('Normalized Density(mm\timesmm)', 'FontSize', 20)
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 
% 
% 
% 
% N = 4;                 % Order of polynomial fit
% F = 7;                % Window length
% [b,g] = sgolay(N,F);   % Calculate S-G coefficients
% 
% dx = 0.2;
% xLim = 200;
% x = 0:dx:xLim-1;
% 
% y = 5*sin(0.4*pi*x) + randn(size(x));  % Sinusoid with noise
% 
% HalfWin  = ((F+1)/2) -1;
% 
% for n = (F+1)/2:996-(F+1)/2,
%   % Zeroth derivative (smoothing only)
%   SG0(n) = dot(g(:,1),y(n - HalfWin:n + HalfWin));
% 
%   % 1st differential
%   SG1(n) = dot(g(:,2),y(n - HalfWin:n + HalfWin));
% 
%   % 2nd differential
%   SG2(n) = 2*dot(g(:,3)',y(n - HalfWin:n + HalfWin))';
% end
% 
% SG1 = SG1/dx;         % Turn differential into derivative
% SG2 = SG2/(dx*dx);    % and into 2nd derivative
% 
% subplot(3,1,1)
% plot([y(1:length(SG0))', SG0'])
% 
% ylabel('Sinusoid')
% 
% subplot(3,1,2)
% plot([SG1'])
% 
% ylabel('1st derivative')
% 
% subplot(3,1,3)
% plot([SG2'])
% 
% ylabel('2nd derivative')

% peaks = GL_RunAve(peaks, 1);
% loglog(time, peaks, 'o')
% %ylim([120 200])
% %xlim([1 150])
%  title('Myxo Cluster Size Power Law','FontSize', 20, 'LineWidth', 1.5)
%     xlabel('Time (h)','FontSize', 20)
%     ylabel('Length Scale (\mum)','FontSize', 20)
% 
%     
% outpath = ['C:\Users\Guannan\Desktop\PowerLawData.txt']; 
% fID = fopen(outpath, 'w');
% fprintf(fID, 'time(h)\t Length Scale(um) \n');
% fprintf(fID, '%f\t%f \n', [time peaks]');
% fclose(fID);

data = load(outpath)

