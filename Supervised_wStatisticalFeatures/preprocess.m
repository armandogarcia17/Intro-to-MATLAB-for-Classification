function [TrainDataStats] = preprocess(TrainData)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Make functions and intelligent variable names
fs = 1800;
naction = mode(countcats(TrainData.Action)); % Samples in most common action
blocksize = naction/gcd(naction, fs);

statfuns = @(x)[max(x) mean(x) min(x) var(x)];
varnames = strcat(repmat({'max';'mean';'min';'var'},8,1),repelem(cellstr(('1':num2str(8))'),numel({'max';'mean';'min';'var'}),1));

% Apply and append action
TrainDataStats = blockproc(TrainData{:,1:8},[blocksize 1],@(block)statfuns(block.data));
TrainDataStats = array2table(TrainDataStats);
TrainDataStats.Properties.VariableNames = varnames;
TrainDataStats.Action = TrainData.Action(1:blocksize:end);
end