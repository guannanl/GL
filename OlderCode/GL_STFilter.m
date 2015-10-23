clear all;
filepath = ['D:\Desktop_temp\trackingData\DZ2\SMtracklist3.mat'];
FileIn = load(filepath);

FileOut = centro2velocity_new(FileIn);
FileOut = GL_ShapeCheck(FileOut);
FileOut = GL_reversal(FileOut);
% 
% FileOut2 = centro2velocity(FileIn);
% FileOut2 = GL_ShapeCheck(FileOut2);
% FileOut2 = GL_reversal(FileOut2);


tracks = FileOut.tracklist;
trackno = length(tracks);
% 
% tracks2 = FileOut2.tracklist;
% trackno2 = length(tracks2);


RevDis = struct;
vel1 = [];
% vel2 = [];
for ii = 1 %1:trackno
    tracktemp = tracks(ii);
%     tracktemp2 = tracks2(ii);
    
%     vell1 = sqrt((tracktemp.Velocity(:,1).^2 + tracktemp.Velocity(:,2).^2));
%     vell2 = sqrt((tracktemp2.Velocity(:,1).^2 + tracktemp2.Velocity(:,2).^2));
    
%     vel1 = [vel1; vell1];
%     vel2 = [vel2; vell2];
    
%     figure(1)
%     plot(tracktemp.Frameno, tracktemp.Velocity(:,1))
%     hold on
%     plot(tracktemp.Frameno, tracktemp.Velocity(:,2))
%     hold off
%   %plot(tracktemp.Centroid(:,1), tracktemp.Centroid(:,2), '-o')
%     figure(2)
%     plot(tracktemp2.Frameno, tracktemp2.Velocity(:,1))
%     hold on
%     plot(tracktemp2.Frameno, tracktemp2.Velocity(:,2))
%     hold off
%    
%     
%     time = (tracktemp.Frameno).*10./60;
%     reversal = tracktemp.reversal;
%     
%     REV = time.*reversal;
%     REV = nonzeros(sparse(REV));
% 
%     RevDis(ii).rev = REV;
%     RevDis(ii).start = tracktemp.start_frame;
%     RevDis(ii).end = tracktemp.end_frame;
   

    for time =1:30%:length(tracktemp.Frameno)
     Cen = tracktemp.Centroid(time, :);
     NodeList = tracktemp.centerNodesList{time};
     X = NodeList(1,1):.1:NodeList(end, 1);
     Y = interp1(NodeList(:,1), NodeList(:,2), X, 'pchip');
     
     figure(1)
     axis square
     for node = 1:length(X)
     viscircles([X(node),Y(node)], 2);
     end
     hold on
     Q = [Cen(1, :), tracktemp.Velocity(time, :)];
     quiver(Q(1), Q(2), 10*Q(3), 10*Q(4));
     
%      xlim([0 1120])
%      ylim([0 1120])

     clf
      pause(0.5)
    end
     
   




end



%     
%     outpath = ['D:\Desktop_temp\trackingData\DZ2\reverse3_new_ST_1.mat'];
%    save(outpath, 'RevDis')
%     clear all
% 
%   ST =   load(['D:\Desktop_temp\trackingData\DZ2\reverse3_new_ST.mat']);
%   GL =   load(['D:\Desktop_temp\trackingData\DZ2\reverse3_new.mat']);
% STreverseall = [];
% GLreverseall = [];
% for ii = 1: 83
%     STnewRev = diff(ST.RevDis(ii).rev);
%     GLnewRev = diff(GL.RevDis(ii).rev);
%     STreverseall = [STreverseall; STnewRev];
%     GLreverseall = [GLreverseall; GLnewRev];
% %     reverseall = [reverseall; RevDis(ii).rev];
% end
% 
% figure
% hist(STreverseall, 60)
% figure
% hist(GLreverseall, 60)
% 
% 

