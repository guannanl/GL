%% Density Stat
% 
% Dmean = [];
% Dstd = [];
% 
% for ii = [1,2,3,4,5,6,8,9,10,11]
%     
%     GL_tracking_analysis;
%     
%     Dmean = [Dmean; D_mean_temp];
%     Dstd = [Dstd; D_std_temp];
%     
%     disp(sprintf('Now working on track %d', ii));
%     
% end
    

% D = [Dmean, Dstd];
D = sort(D, 1, 'ascend');
D_outpath = ['C:\Users\Guannan\Desktop\Density_result\Density_check.txt'];
fID = fopen(D_outpath, 'w');
fprintf(fID, '%f\t%f \n',D');
fclose(fID);



figure(1)
errorbar([1:10],D(:,1), D(:,2),'ko',...
                               'Linewidth',1.5,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','r',...
                               'MarkerSize',5);
title('Average Cell Number across Experiments', 'FontSize',18)
xlabel('Exp Number','FontSize', 15)
ylabel('Average cell number','FontSize', 15)
dleg = legend('\bf{Average Cell Nnumber}',2);



    