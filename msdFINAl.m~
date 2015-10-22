tic
clear
clc

%NOTE
%this programs gives msd for particle trajectories of varying lengths.
%input are x and y coordinates each in separate files - empty values for
%shorter trajectories are stored as zeros
%if slope=1, you have diffusion if slope>1 particles are travelling faster
%than diffusion
overallIndex = 0;

for ini = 1
    
    overallIndex = overallIndex+1;
    en1 = ini+800;

minlen = 800;
indexfrz = 0;
indexdz = 0;
% en1 = 800;
refslp = 1;
refmag = 1;
% ini = 599;
msdsstorefrz = zeros(en1-ini-1,3);
msdsstoredz2 = zeros(en1-ini-1,3);


for loop1 = 1:3
    loadtext = ['data/DZ2/00',num2str(loop1),'/SMtracklist.mat'];
    a1 = load(loadtext);
    b1 = a1.tracklist(1,1:length(a1.tracklist));
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
        vel        = C1(1,k1).Centroid;
        X1 = centro(ini+1:en1,1);
        Y1 = centro(ini+1:en1,2);
        
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
        time = time/6;
        
        msdsav = msdsav3';
        
        ss = polyfit(log(time(1,1:30)),log(msdsav3(1,1:30)),1);
        slp = ss(1);
        
        if (slp > refslp && msdsav(1,1) > refmag)
            
            slp
            msdsstoredz2(:,index1) = msdsav;
%             figure(1); loglog(time,msdsav3,'b'); hold on;
            indexdz = indexdz + index1;
            
        else
            continue
        end
        
    end
    
    msdsmeanplotDZ2(:,loop1) = mean(msdsstoredz2,2);
    clear a1;
    clear b1;
    clear C1;
    clear r1;
    clear ind1;
    
    
    
end

for loop2 = 2:3
    loadtext = ['data/FrzE/00',num2str(loop2),'/00',num2str(loop2),'SMtracklist.mat'];
    a = load(loadtext);
    b = a.tracklist(1,1:length(a.tracklist));
    for n = 1:length(b);
        b(:,n).TrackL = mean(b(:,n).TrackLen);
    end
    C = nestedSortStruct(b, 'TrackL');
    
    for i = 1:length(C);
        r(1,i) = C(1,i).TrackL;
    end
    
    ind2 = find (r > minlen);
    
    
    index2 = 0;
    
    
    for k= min(ind2):max(ind2)
        
        index2 = index2 +1;
        
        centro     = C(1,k).Centroid;
        X1 = centro(ini+1:en1,1);
        Y1 = centro(ini+1:en1,2);
        
        
        
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
        time = time/6;
        
        msdsav = msdsav3';
        
        ss = polyfit(log(time(1,1:30)),log(msdsav3(1,1:30)),1);
        slp = ss(1)
        
        if (slp > refslp && msdsav(1,1) > refmag)
            
            slp;
            
            msdsstorefrz(:,index2) = msdsav;
            indexfrz = index2 + indexfrz;
%             figure(2); loglog(time,msdsav3,'r'); hold on;
            
        else
            continue
        end
        
    end
    
    msdsmeanplotFrzE(:,loop2) = mean(msdsstorefrz,2);
    clear a;
    clear b;
    clear C1;
    clear r;
    clear ind2;
    
end


msdsFrzE(overallIndex,:) = mean(msdsmeanplotFrzE,2);
msdsDZ2(overallIndex,:)  = mean(msdsmeanplotDZ2,2);

end

figure(33);
% time = time';

loglog(time,(msdsDZ2*(0.085^2)),'LineWidth',2); hold on;



% figure(34);
% time = time';

loglog(time,msdsFrzE*(0.085^2),'rs','MarkerSize',10,'LineWidth',2); hold on;

% loglog(time,1000*time,'k','LineWidth',2); hold on;
% 
% loglog(time,300*time.^2,'k','LineWidth',2); hold on;
% 
% loglog(time,300*time.^0.5,'k','LineWidth',2); hold on;

% plot2svg('msdFINAL.svg');


toc






