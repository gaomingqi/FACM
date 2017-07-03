% Compute Feature maps from input image.
function F = compFeaturemaps(I)
% F: feature maps
% I: input image
f1 = 1;                             % 1 Gray image
f2 = fspecial('log', [3,3], .5);    % 2 LoG filters
f3 = fspecial('log', [5,5], 1);
f4 = gabor_fn(1.5, pi/2);           % 8 Gabor filters
f5 = gabor_fn(1.5, 0);
f6 = gabor_fn(1.5, pi/4);
f7 = gabor_fn(1.5, -pi/4);
f8 = gabor_fn(2.5, pi/2);
f9 = gabor_fn(2.5, 0);
f10 = gabor_fn(2.5, pi/4);
f11 = gabor_fn(2.5, -pi/4);
        
F = subImg(I, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11);

