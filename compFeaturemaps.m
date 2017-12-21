% Compute Feature maps from input image.
function F = compFeaturemaps(I)
% F: feature maps
% I: the given image
f1 = 1;                             % grey-level         
f2 = fspecial('log', [3,3], .5);    % 2 LoG filters
f3 = fspecial('log', [5,5], 1);
f4 = gabor_fn(1.5, pi/2);   % 4 Gabor filters (sigma=1.5, 4 orientations)
f5 = gabor_fn(1.5, 0);
f6 = gabor_fn(1.5, pi/4);
f7 = gabor_fn(1.5, -pi/4);
f8 = gabor_fn(2.5, pi/2);   % 4 Gabor filters (sigma=2.5, 4 orientations)
f9 = gabor_fn(2.5, 0);
f10 = gabor_fn(2.5, pi/4);
f11 = gabor_fn(2.5, -pi/4);

filters = {f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11};

[rows, cols] = size(I);
I = double(I);
% initialize feature maps (rows*cols*11)
F = zeros(rows, cols, 11, 'single');

% compute feature maps from given image I through filtering.
for i = 1:11
    h = filters{i};    % the ith filter
    F(:,:,i) = single(imfilter(I, h, 'symmetric'));
end

