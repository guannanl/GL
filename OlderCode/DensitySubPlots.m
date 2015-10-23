%% Density Sub plots
clear all;

Dmean = [];
Dstd = [];

figcount = 0;
figure 

for ii = [1,2,3,4,5,6,8,9,10,11]
    
    disp(sprintf('Now working on track %d', ii));
    
    figcount = figcount +1; 
    filepath = ['C:\Users\Guannan\Desktop\Density_result\', sprintf('DZ2_%d',ii),'\tracklist.mat'];
    
    %Run GL_tracking_analysis 
    [subplotter, D_mean_temp, D_std_temp] = GL_tracking_analysis(filepath);
    
    Dmean = [Dmean; D_mean_temp];
    Dstd = [Dstd; D_std_temp];

    
    subplot (3,4, figcount);
    plot(subplotter(:,1),subplotter(:,2), '-ko')
    title(sprintf('Total cell number Exp#%d',ii),'FontSize', 10)
    xlabel('Frame Number','FontSize', 10)
    ylabel('Total cell number','FontSize', 10)
    
end

D = [Dmean, Dstd];
Dsort = sort(D, 1, 'ascend');
D_outpath = ['C:\Users\Guannan\Desktop\Density_result\Density_check.txt'];
fID = fopen(D_outpath, 'w');
fprintf(fID, '%f\t%f \n',D');
fclose(fID);



figure
errorbar([1:10],Dsort(:,1), Dsort(:,2),'ko',...
                               'Linewidth',1.5,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','r',...
                               'MarkerSize',5);
title('Average Cell Number across Experiments (Sorted)', 'FontSize',18)
xlabel('Exp Number','FontSize', 15)
ylabel('Average cell number','FontSize', 15)
dleg = legend('\bf{Average Cell Nnumber}',2);


figure 
errorbar([1:10],D(:,1), D(:,2),'ko',...
                               'Linewidth',1.5,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','r',...
                               'MarkerSize',5);
title('Average Cell Number across Experiments (UnSorted)', 'FontSize',18)
xlabel('Exp Number','FontSize', 15)
ylabel('Average cell number','FontSize', 15)
dleg = legend('\bf{Average Cell Nnumber}',2);
