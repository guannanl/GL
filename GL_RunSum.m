%% Running Average
function [Output] = GL_RunSum(Input, WindowSize)

% Compute a running Average on Input array with WindowSize. 
% Note that Input should be a one-dimension array input = (length , 1)
% WindowSize must be odd. 

arraysize = numel(Input);
HalfWindow = (WindowSize - 1)/2;
Output = zeros(arraysize, 1);



for ii = 1: HalfWindow
    
    ind = [1: ii + HalfWindow];
    
    Output(ii,1) = sum(Input(ind,1))*arraysize/length(ind);
end

for ii = (HalfWindow + 1):(arraysize - HalfWindow -1)
    
    ind = [(ii - HalfWindow) : (ii + HalfWindow)];
    
    Output(ii,1) = sum(Input(ind,1))*arraysize/length(ind);
end

for ii = (arraysize - HalfWindow):arraysize
    
    ind = [(ii - HalfWindow): arraysize];
    
    Output(ii,1) = sum(Input(ind,1))*arraysize/length(ind);
end

end

    
    
    
    