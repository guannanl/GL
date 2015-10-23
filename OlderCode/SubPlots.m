%% Plotting Density Related Information 
%Guannan Liu


Dmean = [];
Dstd = [];
Vmean = [];
Vstd = [];

figcount = 0;
expID = [1,2,3,4,5,6,8,9,10,11]';

FrameRate = 10; %seconds

 % Lplot = figure;
 % Dplot = figure;
  Vplot = figure;
%  RCplot = figure;
 % RFplot = figure;
  RSplot = figure;
  AllDplot =figure;
 %AllRplot = figure;
for ii = [1,2,3,4,5,6,8,9,10,11]
    
    disp(sprintf('Now working on track %d', ii));
    
    figcount = figcount +1; 
%     
%     filepath = ['D:\Desktop_temp\trackingData\DZ2\', sprintf('SMtracklist%d.mat', ii)];
%     %filepath = ['D:\Desktop_temp\trackingData\frzE\', sprintf('00%dSMtracklist.mat', expID)];
    filepath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',ii),'\GL_tracklist_shape.mat'];
    
    %% Run GL_tracking_analysis 
    [time, Density, Dplotter, D_mean_temp, D_std_temp, velocity_ave, ... 
        V_mean_temp, V_std_temp, ReversalCount, ReversalFreq, RS, LocalCellave, LocalCellPlotterAll] ...
        = GL_tracking_analysis(filepath);
    
    Dmean = [Dmean; D_mean_temp];
    Dstd = [Dstd; D_std_temp];
    
    
    Vmean = [Vmean; V_mean_temp];
    Vstd = [Vstd; V_std_temp];
 
% %     %% Density SubPlots
%     figure(Dplot)
%     %subplot (3, 4, figcount);
%     subplot (3, 1, figcount);
%     plot(Dplotter(:,1),Dplotter(:,2), '-ko')
%     title(sprintf('Total Cell Number vs Time (Exp#%d)',ii),'FontSize', 10)
%     xlabel('Time(min)','FontSize', 10)
%     ylabel('Total cell number','FontSize', 10)
% 
% 
% 
    %% Velocity SubPlots
    figure(Vplot)
    subplot (3, 4, figcount);
    plot(time,velocity_ave(:,1), '-ko')
    title(sprintf('Velocity vs Time (Exp#%d)',ii),'FontSize', 10)
    xlabel('Time (min)','FontSize', 10)
    ylabel('Velocity (\mum/min)','FontSize', 10)
% % 
% % % 
% 
% 
% %     %% Plot Tracklength Distribution 
%     track = load(filepath);
%     tracklength = tracklen_distribution(track);
%     
%     len_ind = find(tracklength>100);%Threshhold of track length
%     tracklength = tracklength(len_ind);
%    
%     figure(Lplot)
%     %subplot (3, 4, figcount);
%     subplot (3, 1, figcount);
%     hist(tracklength, 20)
%     title(sprintf('Hist Plot of TrackLength Distribution (Exp#%d)',ii),'FontSize', 10)
%     xlabel('Length','FontSize', 10)
%     ylabel('Counts','FontSize', 10)

% 
% 
%     %% Reversal Count Plot
%     figure(RCplot)
%     subplot (3, 4, figcount);
%     plot(time, ReversalCount, '-ko')
%     title(sprintf('Reversal Count vs Time (Exp#%d)',ii),'FontSize', 10)
%     xlabel('Time(min)','FontSize', 10)
%     ylabel('Reversal Count','FontSize', 10)

% %     %% Reversal Freq Plot
% %     figure(RFplot)
% %     subplot (3, 4, figcount);
% %     plot(time, ReversalFreq, '-ko')
% %     title(sprintf('Reversal Freq vs Time (Exp#%d)',ii),'FontSize', 10)
% %     xlabel('Time(min)','FontSize', 10)
% %     ylabel('Reversal Freq','FontSize', 10)
    
    %% Summation of One-Hour Reversal Count Average
    figure(RSplot)
    
    RS = GL_RunAve(RS, 501);
    
    subplot (3, 4, figcount);
    plot(time, RS, '-ko')
    title(sprintf('Reversal Per Hour vs Time (Exp#%d)',ii),'FontSize', 10)
    xlabel('Time(min)','FontSize', 10)
    ylabel('Reversal/H','FontSize', 10)


%     %% Local D vs Time Plots
%     figure(AllDplot)
%     subplot (3, 4, figcount);
%     plot(time, LocalCellPlotterAll(:,2), '-ko')
%     title(sprintf('Local Density vs Time Exp#%d',ii),'FontSize', 10)
%     xlabel('Time(min)','FontSize', 10)
%     ylabel('Local D','FontSize', 10)


%     %% Local D vs R Plots
%     figure(AllRplot)
%     subplot (3, 4, figcount);
%     scatter(LocalCellPlotterAll(:,2), LocalCellPlotterAll(:,4))
%     title(sprintf('Local Density vs Reversal Exp#%d',ii),'FontSize', 10)
%     xlabel('Local D','FontSize', 10)
%     ylabel('R','FontSize', 10)

end

D = [Dmean, Dstd, expID];
V = [Vmean, Vstd];

D_sort = sortrows(D, 1);
% % 

% % D_outpath = ['C:\Users\Guannan\Desktop\Density_result\Density_check.txt']; 
% % fID = fopen(D_outpath, 'w');
% % fprintf(fID, '%f\t%f \n',D');
% % fclose(fID);


% Plot the Unsorted/Sorted Density vs Experiment #
sortDplot = figure;
errorbar([1:10],D_sort(:,1), D_sort(:,2),'ko',...
                               'Linewidth',1.5,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','r',...
                               'MarkerSize',5);
title('Average Cell Number across Experiments (Sorted)', 'FontSize',18)
xlabel('Exp Number','FontSize', 15)
ylabel('Average cell number','FontSize', 15)
dummmmm = 1:numel(D_sort(:,3));
for iii = 1:numel(D_sort(:,3))
    text(iii+0.2, D_sort(iii,1), num2str(D_sort(iii,3)),...
         'FontSize',10,...
         'HorizontalAlignment','center');
end
% dleg = legend('\bf{Average Cell Nnumber}',2);


% Unsorted 
allDplot = figure;
errorbar([1:10],D(:,1), D(:,2),'ko',...
                               'Linewidth',1.5,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','r',...
                               'MarkerSize',5);
title('Average Cell Number across Experiments (UnSorted)', 'FontSize',18)
xlabel('Exp Number','FontSize', 15)
ylabel('Average cell number','FontSize', 15)
dummmmm = 1:numel(D(:,3));
for iii = 1:numel(D(:,3))
    text(iii+0.2, D(iii,1), num2str(D(iii,3)),...
         'FontSize',10,...
         'HorizontalAlignment','center');
end
dleg = legend('\bf{Average Cell Nnumber}',2);



%% Plot the Average Velocity vs Density
V_D_plot = figure;
errorbar(D(:,1),V(:,1), V(:,2),'ko',...
                               'Linewidth',1.5,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','r',...
                               'MarkerSize',5);
title('Average Velocity vs Density', 'FontSize',18)
xlabel('Density','FontSize', 15)
ylabel('Velocity (\mum/min)','FontSize', 15)
dleg = legend('\bf{Velocity}',2); 





    
% %% All Reversal Plot
% %     DVT_fig = figure;
% %     figure(DVT_fig)
% %     scatter3(LocalCellPlotterAll(:,1), LocalCellPlotterAll(:,2), LocalCellPlotterAll(:,3))
% %     xlabel('Frame','FontSize', 15)
% %     ylabel('LocalD','FontSize', 15)
% %     zlabel('V','FontSize', 15)
% % 
% %     DV_fig = figure;
% %     figure(DV_fig)
% %     scatter( LocalCellPlotterAll(:,2), LocalCellPlotterAll(:,3))
% %     xlabel('LocalD','FontSize', 15)
% %     ylabel('V','FontSize', 15)
% % %    
%     DR_fig = figure;
%     figure(DR_fig)
%     scatter( LocalCellPlotterAll(:,2), LocalCellPlotterAll(:,4))
%     xlabel('LocalD','FontSize', 15)
%     ylabel('R','FontSize', 15)
%    
%     
    
    
    
    
   



















