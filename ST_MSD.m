%% Shashi MSD
%function [MSD, TAU] = ST_MSD(trackIn, tracklenmin)
%Trajectory should be n by 2 matrix: [x,y].
clear all;
tracklenmin = 300;
MSDplot = figure;
figurecount = 0;

MeanNumber = [ 46.3011,57.7795,58.5158,150.3700,310.5508,323.3300];
% for expID = [4,6,9,11,5,2] %[1,2,3,4,5,6,8,9,10,11]
% %close all;
% figurecount = figurecount + 1;
% filepath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',expID),'\GL_tracklist_shape.mat'];
    
% trackIn = load(filepath);
ini = 1;
 %overallIndex = overallIndex+1;
    en1 = ini+tracklenmin;
minlen = tracklenmin;
%indexfrz = 0;
indexdz = 0;
% en1 = 800;
refslp = 1.3;
refmag = 1;
% ini = 599;
msdsstoredz2 = zeros(en1-ini-1,3);
for loop1 = 1
%     loadtext = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',loop1),'\GL_tracklist.mat'];
trackIn = load(['D:\Desktop_temp\trackingData\DZ2\SMtracklist1.mat']);
%     a1 = load(loadtext);
    b1 = trackIn.tracklist(1,1:length(trackIn.tracklist));
    for n = 1:length(b1);
        b1(:,n).TrackL = mean(b1(:,n).TrackLen);
    end
    C1 = nestedSortStruct(b1, 'TrackL');
    
    for i = 1:length(C1);
        r1(1,i) = C1(1,i).TrackL;
    end
    
    ind1 = find (r1 > minlen);
    
    index1 = 0;
    
    
    for k1= min(ind1):max(ind1)
        
        index1 = index1 +1;
        
        centro     = C1(1,k1).Centroid;
        %vel        = C1(1,k1).Centroid;
        X1 = centro(ini+1:en1,1);
        Y1 = centro(ini+1:en1,2);
        if ismember(k1, min(ind1):10:max(ind1))
            figure
         plot(X1 - X1(1,1), Y1 - Y1(1,1), '-o', 'Color', [rand, rand, rand])
         
        end
        
        X2     = X1(1:(end-1));
        
        X3     = (diag(X2')*hankel(ones(1,length(X2))))';
        X4     = hankel(X1(2:end));
        
        Y2     = Y1(1:(end-1));
        
        Y3     = (diag(Y2')*hankel(ones(1,length(Y2))))';
        Y4     = hankel(Y1(2:end));
        
        
        msdsx  = ((X4 - X3));
        msdsy  = ((Y4 - Y3));
        
        msds   = (msdsx.^2 + msdsy.^2);
        
        factor = (size(msds)):-1:1;
        msdsav2 = ones(1,length(msds))*(msds');
        msdsav3 = msdsav2./factor;
        time   = 1:(size(msds));
        TAU = time/6;
        
        msdsav = msdsav3';
        
        ss = polyfit(log(time(1,1:30)),log(msdsav3(1,1:30)),1);
        slp = ss(1);
        
        if (slp > refslp && msdsav(1,1) > refmag)
            
           % slp;
            msdsstoredz2(:,index1) = msdsav;
%             figure(1); loglog(time,msdsav3,'b'); hold on;
            indexdz = indexdz + index1;
            
        else
            continue
        end
        
    end
    
    msdsmeanplotDZ2(:,1) = mean(msdsstoredz2,2);
%     clear a1;
%     clear b1;
%     clear C1;
%     clear r1;
%      clear ind1;
%    
%     MSD = mean(msdsmeanplotDZ2,2);
%     figure(MSDplot)
%     subplot (2, 3, figurecount);
%     loglog(TAU,(MSD*(0.085^2)),'-s')
%     title(sprintf('AveD = %.02f', MeanNumber(figurecount)),'FontSize', 12)
%     xlabel('Time (min)','FontSize', 15)
%     ylabel('MSD(\mum^2)','FontSize', 15)
    
    %plot(X1 - X1(1,1), Y1 - Y1(1,1), '-ko')
    
%end

end

 
        

