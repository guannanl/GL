%% Calculate Presistence Length of a track
close all
clear all
%% Load tracks
filepath = '/Volumes/GL_Passport_2/Density_analysis/Density_result/DZ2_11';
track = load(fullfile(filepath, 'tracklist.mat'));
track = track.tracklist;

%% Sort tracks 
trackno = length(track);
trackL_thresh = 100;
TempCentr = cell(trackno,1);
ind = 1;
for i = 1:trackno
    if length(track(i).Frameno) >= trackL_thresh
        TempCentr{ind} = track(i).Centroid;
        ind = ind + 1;
    end
end
Centr = cell(ind - 1, 1);
TRACKS = cell(ind - 1, 1);

for i = 1 : ind - 1
    time = ((1:length(TempCentr{i})).*10./60)'; %s
    Centr{i} = TempCentr{i}.*0.08; %um
    TRACKS{i} = [time, Centr{i}];
end
trakcno = ind - 1;

% Clear old structs, use TRACKS now
clear Centr ind TempCentr track

%% Manual track number
tk =  34
tk = 8;

%% Plot Tracks
colors = jet(trackno);
figure(2)
for i = tk %1 :trackno
    x = TRACKS{i}(:,2);
    y = TRACKS{i}(:,3);
    plot(x, y, '-x',...
        'Color', colors(i, :),...
        'DisplayName', num2str(i))
    clear x y
    hold on
end

%% Load MSD Analyzer
Temp = TRACKS(tk);
ma = msdanalyzer(2, 'um', 'min');
ma = ma.addAll(Temp);

%% Velocity Hist
% v = ma.getVelocities;
% V = vertcat( v{:} );
% figure(1)
% histogram(V(:,2:end))
% xlabel('Velocity')
% ylabel('#')

%% V Corr
ma = ma.computeVCorr;
vcorr = ma.vcorr;
vcorr = vcorr{1};

%% Plot Mean Corr
tau = vcorr(3:end,1);
Corr = vcorr(3:end,2);
figure(3)
plot(tau, Corr, '-k', ...
    'LineWidth', 2)
hold on
plot(0:1:30, (0:1:30).*0, '-r', ...
     'LineWidth', 1)
xlabel('\tau (min)', 'FontSize', 20)
ylabel('V Corr (\mum^2/min)', 'FontSize', 20)
hold off


%% Get Dr dnding at around 20 min
T = round(length(tau)*20/35);
tau = tau(1:T);
Corr = Corr(1:T);

figure
plot(tau, Corr, '-xk', ...
    'LineWidth', 1, ...
    'MarkerSize', 2)
hold on
plot(0:1:30, (0:1:30).*0, '-r', ...
     'LineWidth', 1)
xlabel('\tau (min)', 'FontSize', 20)
ylabel('Non-Normalized V Corr (\mum^2/min)', 'FontSize', 20)
hold on

%% Non-Linear Fit with Exp Decay 
F = @(x,xdata)x(1)*exp(-xdata/x(2)) + x(3);
% Initialize x0 = [x(1), x(2), x(3)]
x0 = [1,1,0];
% Fitting
[x,resnorm,~,exitflag,output] = lsqcurvefit(F,x0,tau,Corr);

plot(tau,F(x,tau), '-r', ...
     'LineWidth', 3)
hold on
str = sprintf('D_r = %4f min', x(2));
h = annotation('textbox',[.5 .5 .3 .3],...
               'String',str,'FitBoxToText','on');
h.FontSize = 20;
hold off
