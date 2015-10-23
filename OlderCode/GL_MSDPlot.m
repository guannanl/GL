%% MSD Plot 
MSDplot = figure;
figcount = 0;
MSD_all = [];
TAU_all = [];
for expID = [1,2,3] %[1,10,8,4,6,9,3,11,2,5]
    
    disp(sprintf('Now working on track %d', expID));
    
    figcount = figcount +1; 
    
    filepath = ['D:\Desktop_temp\trackingData\DZ2\', sprintf('SMtracklist%d.mat', expID)];
    %filepath = ['D:\Desktop_temp\trackingData\frzE\', sprintf('00%dSMtracklist.mat', expID)];
    
    %filepath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',expID),'\GL_tracklist.mat'];
    
    TrackIn = load(filepath);
    
%% 1. Sort the TrackOut

TrackOut = GL_MSD(TrackIn, 200);

trackno = length(TrackOut.tracklist);
MSDLen = 0;

for ii = 1:trackno 
    MSDLen = MSDLen + length(TrackOut.tracklist(ii).MSD(:,1));
end

MSD = zeros(MSDLen,2);
ind1 = 1;
for ii = 1:trackno
    ind2 =  ind1 + length(TrackOut.tracklist(ii).MSD(:,1)) - 1;
    MSD(ind1:ind2,1) = TrackOut.tracklist(ii).MSD(:,1);
    MSD(ind1:ind2,2) = TrackOut.tracklist(ii).MSD(:,2);
    
    ind1 = ind2; 
end

%% PLot
MSD = sort(MSD, 1);
index0 = find(MSD(:,1)>0);
msd = MSD(index0, 1);
msd = msd*(0.081*0.082);
tau = MSD(index0, 2);

uniq_tau = unique(tau);
uniq_msd = zeros(length(uniq_tau),1);


for jj = 1:length(uniq_tau)
    ind = find(tau == uniq_tau(jj));
    uniq_msd(jj) = mean(msd(ind));
end
uniq_tau = uniq_tau*10/60;

% ind = find(uniq_tau<150);
% 
% uniq_tau = uniq_tau(ind);
% uniq_msd = uniq_msd(ind);
% 
% curve_slope = [0; diff(uniq_msd)./diff(uniq_tau)];

MSD_all = [MSD_all; uniq_msd];
TAU_all = [TAU_all; uniq_tau];

 %% MSD SubPlots
    figure(MSDplot)
    subplot (3, 1, figcount);
    loglog(uniq_tau, uniq_msd,'-s')
    %loglog(uniq_tau, curve_slope, '-s')
    title(sprintf('MSD vs Time (DZ2Exp#%d)',expID),'FontSize', 10)
    ylabel('MSD (\mum^2)','FontSize', 10)
    xlabel('Time(min)','FontSize', 10)



end

tau_ave = unique(TAU_all);
msd_ave = zeros(length(tau_ave),1);
for iii = 1:length(tau_ave)
    ind = find(TAU_all == tau_ave(iii));
    msd_ave(iii) = mean(MSD_all(ind));
end



    AVEplot = figure;
    figure(AVEplot)
    loglog(tau_ave, msd_ave,'-s')
    %loglog(uniq_tau, curve_slope, '-s')
    title('MSD vs Time Ave','FontSize', 10)
    ylabel('MSD (\mum^2)','FontSize', 10)
    %xlim([0.1 1000])
    xlabel('Time(min)','FontSize', 10)
    %ylim([0.1 1000])
