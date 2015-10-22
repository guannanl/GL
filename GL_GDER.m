function [Dy] = GL_GDER(y, order, WSize, sigFactor )
%% Differentation using Gaussian Derivative
%[Dy] = GL_GDER(y, order, WSize, sigFactor )
% Taking derivative of data using gaussian derivative. 
% y is the data
% Wsize is the window size of gaussian. If not specified, Wsize = length(y).
% SigFactor is the width factor of gaussian. 
% If not specified, Sigfactor = 3.
% order = 0 : just smoothing
% order = 1 : 1st order dericative;
%
if nargin < 2
    order = 1;
end 

if nargin < 3
    WSize = length(y) ;
end

if nargin < 4
    sigFactor = 3;
end

N = floor(WSize/2);
sig = N/sigFactor;
t = 0:2*N;

G = exp(-((t - mean(t)).^2)/(2*sig^2))/(2*pi*sig);
Gt = -(t - mean(t)).*G/(sig^2);
G = G/sum(sqrt(G(:).^2));
Gt = Gt/sum(sqrt(Gt(:).^2));

switch order
    case 0
        Dy = conv(y, G, 'same');
        
    case 1
        Dy = conv(y, Gt, 'same');
    otherwise
        disp('Not a Valid Order');
end
