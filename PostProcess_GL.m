 j = 1;
     [x1] = 0;
     [y1] = 0;
     [xlast] = 0;
     [ylast] = 0;
     while(true)
            if orderedDataSet(j,1) == 0
                [tempx] = [x1; orderedDataSet(j, 2)];
                [x1] = [tempx];
                [tempy] = [y1; orderedDataSet(j, 3)];
                [y1] = [tempy];
            else
                break;
            end
            j = j + 1;
     end
     s = size(orderedDataSet);
     j = s(1,1);
     
     rawimage =  imread('0000.tif');
     imshow(rawimage);
     hold on
     scatter(x1,y1);
     hold off
     
     while(true)
   
            if orderedDataSet(j, 1) == 1240
                [tempx] = [xlast; orderedDataSet(j, 2)];
                [xlast] = [tempx];
                [tempy] = [ylast; orderedDataSet(j, 3)];
                [ylast] = [tempy];
            else
                break;
            end 
            j = j - 1;
     end
    
     figure
     
     lastimage =  imread('1241.tif');
     imshow(lastimage);
     hold on
     scatter(xlast,ylast);
     hold off
   
         