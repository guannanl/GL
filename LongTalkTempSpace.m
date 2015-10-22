%% For Each TrackData:
clear all; 
close all;
    Onehour = 60*60/10;
    fivemin = 5*60/10;
    figurecount = 0;
    expID = [4,6,9,11,5,2];%[10,4,8,6,9,3,11,5,2];%[1,10,4,8,6,9,3,11,5,2];
    
    expNumber = length(expID);
    DensityAllMean = zeros(expNumber,1);
    VelocityAllMean= zeros(expNumber,1);
    VelocityAllSTD = zeros(expNumber,1);
    D = figure;
    V = figure;
    R = figure;
    N = figure;
    
for expID = [4,6,9,11,5,2];


    figurecount = figurecount + 1;

%filepath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',expID),'\GL_tracklist_shape.mat'];

filepath = ['D:\Desktop_temp\Density_result\', sprintf('DZ2_%d',expID),'\GL_tracklist_shape.mat'];

track = load(filepath);

orderedData = track_order_ST(track);

%      dataset = [ frame1(2:end,1) centrx1(2:end,1) centry1(2:end,1) ... 
%          vx1(2:end,1) vy1(2:end,1) rev(2:end,1) CellLen(2:end,1) Neighbor(2:end,1)];
% 
%      orderedDataSet = sortrows(dataset,1);
     

%% 1. Time
    frames = orderedData(:,1);
    uniq_frames = unique(orderedData(:,1));
    
    FrameRate = 10; %second
    Time = (uniq_frames .* FrameRate)/60;  %min
    
    
%% 2. Overall Density vs. Time

    Density = zeros(length(uniq_frames),1);
    
    for ii = 1: length(uniq_frames)
        ind_d = find(frames == uniq_frames(ii,1));
        Density(ii,1) = length(ind_d);
        %Get rid of bad data
        
        if (ii > 1 && Density(ii, 1) < 15)
            Density(ii, 1) = Density(ii-1, 1);
        end
    end 
    
    MeanNumber = mean(Density(Density>10))
    STDNumber = std(Density);
    
    DensityPlot = GL_RunAve(Density, 51);
    figure(D)
    subplot (3, 3, figurecount);
    plot(Time, Density, 'ro', 'MarkerSize', 3 )
    hold on
    plot(Time, DensityPlot, 'b-', 'LineWidth', 1.5)
    title(sprintf('Total Cell# vs Time \n AveD = %.02f \n STD = %.02f', MeanNumber, STDNumber),'FontSize', 12)
    xlabel('Time (min)','FontSize', 15)
    ylabel('Cell#','FontSize', 15)
    

    DensityAllMean(figurecount) = MeanNumber;
    
%% 3. Overall Velocity with time
% % 
%     VelocityMean  = zeros(length(uniq_frames),1);
%     VelocitySTD  = zeros(length(uniq_frames),1);
%     
%     for ii = 1: length(uniq_frames)
%         
%         ind_v = find(frames == uniq_frames(ii,1));
%         vtemp_x = orderedData(ind_v, 4);
%         vtemp_y = orderedData(ind_v, 5);
%         
%         vtemp = sqrt(vtemp_x.^2 + vtemp_y.^2);
%         
%                
% %         vtemp_mean =  mean(vtemp(vtemp>0 & vtemp< 10));
% %         vtemp_std = std(vtemp((vtemp>0 & vtemp<10)));        
%          
%         vtemp_mean =  mean(vtemp(vtemp< 10));
%         vtemp_std = std(vtemp((vtemp<10)));
% 
%         
%         VelocityMean(ii) = vtemp_mean;
%         VelocitySTD(ii) = vtemp_std;
%     end 
%     
%     VelocityMean = GL_RunAve(VelocityMean, 51);
%     VelocitySTD = GL_RunAve(VelocitySTD, 51);
%     
%     figure(V)
%     subplot (3, 3, figurecount);
%     plot(Time, VelocityMean, 'b', 'LineWidth',2)
%     hold on
% %     plot(Time, VelocityMean + VelocitySTD, 'r')
% %     hold on
% %     plot(Time, VelocityMean - VelocitySTD, 'r')
%     title(sprintf('Average Velocity vs Time (Exp#%d)',expID),'FontSize', 15)
%     xlabel('Time (min)','FontSize', 15)
%     ylabel('Velocity(\mum/min)','FontSize', 15)
%     
%     VelocityAllMean(figurecount) = nanmean(VelocityMean);
%     VelocityAllSTD(figurecount) = nanstd(VelocityMean);
    
%% 4. Overall Reversals
    Reversal = zeros(length(uniq_frames),1); 

    for ii = 1:length(uniq_frames)
        ind_r = (frames == uniq_frames(ii,1));
        Reversal(ii,1) = sum(orderedData(ind_r, 6));
    end
    
    Reversal = Reversal./Density;
    
    %Reversal = GL_RunSum(Reversal, 51);
    
   % Reversal = Reversal*Onehour;
    

    PointNumber = floor(length(uniq_frames)/fivemin);
%     ReversalAve = zeros(PointNumber,1);
%     ReversalSTD = zeros(PointNumber,1);
    ReversalAve = [];
    ReversalSTD = [];
    ReversalAveTime = [];
    for jj = 0: PointNumber
        if (jj*fivemin + Onehour)<length(uniq_frames)
        ReversalAve(jj + 1) = sum(Reversal((jj*fivemin + 1):(jj*fivemin + Onehour)));
        ReversalSTD(jj + 1) = std(Reversal((jj*fivemin + 1):(jj*fivemin + Onehour)));
        ReversalAveTime(jj + 1) = (jj+1)*5;
        end
    end
    
    figure(R)
    subplot (3, 3, figurecount);
    errorbar(ReversalAveTime, ReversalAve, ReversalSTD, '-ko',...
                               'Linewidth',1.5,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','r',...
                               'MarkerSize',8);
    title(sprintf('Reversal Rate vs Time (Exp#%d)\n AveDensity = %.02f',expID, MeanNumber),'FontSize', 12)
    ylabel('Reversals per Hour','FontSize', 15)
    xlabel('Time(min)','FontSize', 15)
    

    
    
    
%% 5. Neighbour Number

    Neighbour = zeros(length(uniq_frames),1); 

    for ii = 1:length(uniq_frames)
        ind_r = (frames == uniq_frames(ii,1));
        Neighbour(ii,1) = mean(orderedData(ind_r, 8));
    end
    
        PointNumber = floor(length(uniq_frames)/fivemin);
    NeighbourAve = [];
    NeighbourSTD = [];
    NeighbourAveTime = [];
    for jj = 0: PointNumber
        if (jj*fivemin + Onehour)<length(uniq_frames)
        NeighbourAve(jj + 1) = mean(Neighbour((jj*fivemin + 1):(jj*fivemin + Onehour)));
        NeighbourSTD(jj + 1) = std(Neighbour((jj*fivemin + 1):(jj*fivemin + Onehour)));
        NeighbourAveTime(jj + 1) = (jj+1)*5;
        end
    end
    
    
    
    figure(N)
    subplot (3, 3, figurecount);
    errorbar(NeighbourAveTime, NeighbourAve, NeighbourSTD, ...%'-ko',...
                               'Linewidth',1.5,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','r',...
                               'MarkerSize',8);
    title(sprintf('Neighbour Number vs Time (Exp#%d)\n AveDensity = %.02f',expID, MeanNumber),'FontSize', 15)
    ylabel('Neighbour Number','FontSize', 15)
    xlabel('Time(min)','FontSize', 15)
    
    
end


    
    
    

   
    
    
    
    
    
    
    
    
    
    
    
    