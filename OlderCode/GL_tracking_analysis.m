%% Check Tracking results
function [Time, Density, Densityplotter, D_mean_temp, D_std_temp, velocity_ave, V_mean_temp, ...
    V_std_temp, ReversalCount, ReversalFreq, ReversalSum, LocalCellAve, LocalCellPlotterAll] ...
     = GL_tracking_analysis(filepath)

%close all
%Ask for path


%% Load the frame info using Shashi's orderDataset

if nargin == 0
selectpath = uigetdir;
filepath = fullfile(selectpath,'GL_tracklist_shape.mat');
end

track = load(filepath);
% 
% %% Do you want velocity from centroid position??
% 
% track = centro2velocity(track);
% 
% %% Calculate Reversals
% 
% track = GL_reversal(track);

%% Sort Data (Shashi)
    %Data Structure after sorting: 
    %[Frame, Centroid X, Centroid Y, Velocity X, Velocity Y, Reversal, CellLength, Neighbor].
    %Sorted by frame number. 

orderedData = track_order_ST(track);

%% Construct the Frames Numbers

    frames = orderedData(:,1);
    uniq_frames = unique(orderedData(:,1));
    
    FrameRate = 10; %second
    Time = (uniq_frames .* FrameRate)/60;  %min

%% Check Density

    Density = zeros(length(uniq_frames),1);
    
    for ii = 1: length(uniq_frames)
        ind_d = find(frames == uniq_frames(ii,1));
        Density(ii,1) = length(ind_d);
    end 
    
    % Plot Density vs frame # 
    Densityplotter = [uniq_frames, Density];
    Densitytemp  = [];
    
    
    %Get rid of meaningless density points
    for jj = 1: length(Densityplotter)
        if Densityplotter(jj, 2) < 15   %Threshhold of track length 
            Densitytemp = [Densitytemp;jj];
        end
    end
    
    Densityplotter(Densitytemp, :) = [];
    
    %Plot with sgolay smoothing
    Densityplotter(:,2) = sgolayfilt(Densityplotter(:,2), 3, 25);
   
%     plot(densityplotter(:,1),densityplotter(:,2), '-ko')
%     title('Total cell number vs. Frame Number','FontSize', 20)
%     xlabel('Frame Number','FontSize', 15)
%     ylabel('Total cell number','FontSize', 15)
%     dleg = legend('\bf{total cell number}');
%     grid on

    D_mean_temp = mean(Densityplotter(:,2));
    D_std_temp = std(Densityplotter(:,2));
    
%% Check Velocity 
    velocity = [];
    
    for ii = 1: length(uniq_frames)
        
        ind_v = find(frames == uniq_frames(ii,1));
        vtemp_x = orderedData(ind_v, 4);
        vtemp_y = orderedData(ind_v, 5);
        
        vtemp = sqrt(vtemp_x.^2 + vtemp_y.^2);
        velo_ind = [];
        for jj = 1:length(vtemp(:))
            if abs(vtemp(jj)) < 50 %Threshhold for meaningless velocity
                velo_ind = [velo_ind, jj];
            end
        end
               
        vtemp_mean =  mean(vtemp(velo_ind));
        vtemp_std = std(vtemp(velo_ind));
        
        velocity_temp = [vtemp_mean, vtemp_std];
        velocity = [velocity; velocity_temp];
    end 
    
    
    
    velocity_ave = [sgolayfilt(velocity(:,1), 3, 21), ...
                    sgolayfilt(velocity(:,2), 3, 21)];  
            
    timepoint = 40*60/10;
    V_mean_temp = nanmean(velocity_ave(timepoint:(end-50),2));
    V_std_temp = nanstd(velocity_ave(timepoint:(end-50),2));
    
%     
%     V_mean_temp = nanmean(velocity_ave(:,2));
%     V_std_temp = nanstd(velocity_ave(:,2));
    
% figure 
% % errorbar(uniq_frames,velocity_ave(:,1), velocity_ave(:,2),'kx',...
% %                                'Linewidth',1.5,...
% %                                'MarkerEdgeColor','k',...
% %                                'MarkerFaceColor','r',...
% %                                'MarkerSize',5);
% 
% plot(uniq_frames, velocity_ave(:,1), 'kx')
% title('Average Velocity vs Frame Number', 'FontSize',18)
% xlabel('Frame Number','FontSize', 15)
% ylabel('Average Velocity(\mu m/min)','FontSize', 15)
% dleg = legend('\bf{Average Cell Nnumber}',2);
%     
    
%% Check Reversal Frequency
    ReversalCount = zeros(length(uniq_frames),1); 

    for ii = 1:length(uniq_frames)
        ind_r = (frames == uniq_frames(ii,1));
        ReversalCount(ii,1) = sum(orderedData(ind_r, 6));
    end
    
    ReversalFreq = ReversalCount./Density;
    RSTime = 1*60*60/FrameRate;
    ReversalSum = GL_RunSum(ReversalFreq, (floor(RSTime/2)*2 + 1));
    
    
%% Local Density 
    LocalCellAve = zeros(length(uniq_frames),1);
    LocalCellVAve = zeros(length(uniq_frames),1);
    
    for ii = 1:length(uniq_frames)
        ind_ld = (frames == uniq_frames(ii,1));
        LocalCellAve(ii,1) = mean(find(orderedData(ind_ld, 8)> -0.5));
    %    LocalCellVAve(ii,1) = mean(sqrt(orderedData(ind_ld, 4).^2 + orderedData(ind_ld, 5).^2));
    end
    

    
    %velocityeach = sqrt(orderedData(:, 4).^2 + orderedData(:, 5).^2);
    %LocalCellPlotterAll = [uniq_frames, LocalCellAve, LocalCellVAve, ReversalFreq];
 
    LocalCellPlotterAll = [Time, LocalCellAve, velocity, ReversalFreq];
    
%[Frame, Centroid X, Centroid Y, Velocity X, Velocity Y, Reversal, CellLength, Neighbor].

end 
    
    
        
        
        
       
    


    
