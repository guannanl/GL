close all
clear all
clc

SPACE_UNITS = '�m';
TIME_UNITS = 's';
SIZE = 2; % �m
N_PARTICLES = 10;
N_TIME_STEPS = 100;
N_DIM = 2; % 2D
D  = 1e-3; % �m^2/s
dT = 0.05; % s
k = sqrt(2 * D * dT);

tracks = cell(N_PARTICLES, 1);
for i = 1 : N_PARTICLES

    time = (0 : N_TIME_STEPS-1)' * dT;
    X0 = SIZE .* rand(1, N_DIM);

    % Integrate uncorrelated displacement
    dX = k * randn(N_TIME_STEPS, N_DIM);
    dX(1, :) = X0;
    X = cumsum(dX, 1);

    % Store
    tracks{i} = [time X];

end
clear i X dX time X0