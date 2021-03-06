filepath = ['TempData/tracklist.mat'];

a1 = load(filepath);
     b1 = a1.tracklist(1,1:length(a1.tracklist));
     for n = 1:length(b1);
         b1(:,n).TrackL = mean(b1(:,n).TrackLen);
     end
     C1 = nestedSortStruct(b1, 'TrackL');

     [frame1] = 0;
     [centrx1] = 0;
     [centry1] = 0;
     [vx1] = 0;
     [vy1] = 0;
     [ang] = 0;

     for i = 1:length(C1);
         [t1] = [ frame1; C1(:,i).Frameno];
         [frame1] = [t1];


         centro     = C1(1,i).Centroid;
         X1 = centro(:,1);
         Y1 = centro(:,2);

         velo     = C1(1,i).Velocity;
         VX1 = velo(:,1);
         VY1 = velo(:,2);


         [t2] = [centrx1; X1];
         [centrx1] = [t2];

         [t3] = [centry1; Y1];
         [centry1] = [t3];

         [t5] = [vx1; VX1];
         [vx1] = [t5];

         [t6] = [vy1; VY1];
         [vy1] = [t6];

         clear t1;
         clear t2;
         clear t3;

     end
% 
%      clear a1;
%      clear b1 ;
%      clear C1;

     dataset = [ frame1(2:end,1) centrx1(2:end,1) centry1(2:end,1) vx1(2:end,1) vy1(2:end,1)];

     orderedDataSet = sortrows(dataset,1);
     



    

    
     
    
     

     
     
     
                
          
                
         
     
