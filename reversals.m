tic
clear
clc
% x = [ 0 0 0 1 2 3 4 0; 2 3 4 0 0 0 0 0; 0 4 5 6 0 0 0 0];
%
% y = [ 0 0 0 1 2 3 4 0; 2 3 4 0 0 0 0 0; 0 4 5 6 0 0 0 0];


minlen = 30;
%for loop1 = 1:3
loop1 = 1;
    %loadtext = ['data/DZ2/00',num2str(loop1),'/SMtracklist.mat'];
    loadtext = ['C:\Users\Guannan\Desktop\Density_result\DZ2_1\tracklist.mat'];
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
    
    nrev = 0;
    
    
    for k1= min(ind1):max(ind1)
        
        index1 = index1 +1;
        
        centro     = C1(1,k1).Centroid;
        startF(index1,1) = C1(1,k1).start_frame;
        X1 = centro(:,1);
        Y1 = centro(:,2);
        
        X2 = X1(1:end-1);
        X3 = X1(2:end);
        
        Y2 = Y1(1:end-1);
        Y3 = Y1(2:end);
        
        velo       = C1(1,k1).Velocity;
        VX1 = velo(:,1);
        VY1 = velo(:,2);
        
        vel = sqrt(VX1.^2 + VY1.^2);

        for i = 1:length(X1)-1
            if (((VX1(i+1) < 0 && VX1(i) > 0)||(VX1(i+1) > 0 && VX1(i) < 0)||VX1(i) == 0)||((VY1(i+1) < 0 && VY1(i) > 0)||(VY1(i+1) > 0 && VY1(i) < 0)||VY1(i) == 0))
                reversal(startF(index1,1) +i,index1) =1;

            else
                reversal(startF(index1,1) +i,index1) = 0;

            end
        end
      
        
        clear centro;
        clear velo;
        clear X1;
        clear Y1;
        clear VX1;
        clear VY1;
        
        clear ang1;
        clear ang2;
        clear ang3;
        %             clear angdiff;
        
        
        
    end
    
    reversalData(loop1,1).str = reversal;
    
    clear reversal;
    
    clear C1;
    clear ind1;
    
%end

% end
