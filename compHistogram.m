% Compute local histogram from feature maps
function H = compHistogram(F, window_size, bins)
% H: local histogram
% F: feature maps
% scale: size of local window
% bins: bins of histogram data
F = single(F);
[rows, cols, channels] = size(F);

sh_mx = SHcomp(channels, floor(window_size/2), F);

bb = size(sh_mx, 1);

H = reshape(sh_mx, bb, rows*cols);
