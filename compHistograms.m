% Compute local histogram from feature maps
function H = compHistograms(F, scale)
% H: local histogram
% F: feature maps
% scale: size of local window
F = single(F);
[rows, cols, channels] = size(F);

% compute histograms from feature maps (multi-channel)
H_map = SHcomp(channels, floor(scale/2), F);
M = size(H_map, 1); % compute the size of each histogram feature

% convert multi-channel H into the histogram matrix (M*N)
% where M means the size of histogram features, N means the number of
% pixels in given image I
H = reshape(H_map, M, rows*cols);