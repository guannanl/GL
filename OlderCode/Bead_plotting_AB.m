%% Bead Data Plotting for Akeisha
close all
prefile = ['C:\Users\Guannan\Desktop\For Akeisha\Bead_data\'];

for i = 5
    filestring = sprintf('data%d',i);
    filename = [prefile,filestring];
    
    bead = load(filename);

    time = bead(:,1);
    
    time = time - time(1,1);
    
    bx_um = bead(:,2);
    by_um = bead(:,3);
    
    tx_um = bead(:,4);
    ty_um = bead(:,5);
    
    B_dis = sqrt(bx_um.^2 + by_um.^2);
    t_dis = sqrt(tx_um.^2 + ty_um.^2);
    
    %% Home build derivative 
%     %calcualte the time increment
%     ind = length(time(:));
%     temp_time  = [0];
%     temp_bx = [0];
%     temp_by = [0];
%     temp_tx = [0];
%     temp_ty = [0];
%     
%     for ii = 2:ind
%         temp_time(ii,1) = time(ii-1,1);
%         temp_bx(ii,1) = bx_um(ii-1,1);
%         temp_by(ii,1) = by_um(ii-1,1);
%         temp_tx(ii,1) = tx_um(ii-1,1);
%         temp_ty(ii,1) = ty_um(ii-1,1);
%     end
%     
%     dtime = time - temp_time;
%     dbx = bx_um - temp_bx;
%     dby = by_um - temp_by;
%     dtx = tx_um - temp_tx;
%     dty = ty_um - temp_ty;
    
%% Try the gradient function
     iii = 1;
for h = 1: 10:100;
        iii = iii+1;
      dtime = gradient(time, h);
      dbx = gradient(bx_um, h);
      dby = gradient(by_um, h);
      dtx = gradient(tx_um, h);
      dty = gradient(ty_um, h);


    Vbx = dbx./dtime;
    Vby = dby./dtime;
    Vtx = dtx./dtime;
    Vty = dty./dtime;  
    
    Vb = sqrt(Vbx.^2 + Vby.^2);
    Vt = sqrt(Vtx.^2 + Vty.^2);
    
    stiffx = 0.1100;
    stiffy = 0.2000;
    
    Fx = tx_um .* stiffx;
    Fy = ty_um .* stiffy;
    
    Ftot = sqrt(Fx.^2 + Fy.^2);
    
    
   % figure
%     plot(time, B_dis)
%     hold on
%     plot(time, t_dis)
%     hold off
    
    subplot(3,4,iii-1)
    plot(time, Vb)
    title(sprintf('H = %d',h))
end 
    

end