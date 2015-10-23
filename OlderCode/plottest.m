close all; 

% y1 = x.*(10 - x);
% y2 = -(25/9)*(2 - x).*( 8- x);
% figure(1)
% plot(x, y1, 'Color', 'b', 'LineWidth',2)
% hold on
% plot(x, y2, 'Color', 'r', 'LineWidth',2)
% ylim([0 26])
x = 0:0.01:10;
y = 3.*sin(x.*pi/2) +2.*randn(length(x),1)';


slopetest = [0, diff(y)./0.01];


mean(slope1)
slope1 = GL_GDER(y, 0, length(y), 10);
slope2 = GL_GDER(y, 1, length(y), 10);


figure(1)
% plot(x, slope1)
% hold on 
plot(x, slope2, 'LineWidth', 3)
hold on
plot(x, y)
hold on 
plot(x,  slope1, 'k', 'LineWidth', 2)

