% This project demonstrates the texture segmentation method in paper:
%   "A factorization based active contour model for texture segmentation", 
%   Mingqi Gao, Hengxin Chen, Shenhai Zheng, Bin Fang, 
%   IEEE International Conference on Image Processing, pp 4309-4313, 2016

% Main References in our project: 
% [1] Yuan J, Wang D, Cheriyadat A M, 
%    "Factorization based Texture Segmentation",
%    IEEE Trans. Image Processing, vol. 24 (11), pp.3488-3497, 2015.
% [2] Li C, Xu C, Gui C, et al, 
%    "Level Set Evolution without Re-Initialization: A New Variational Formulation",
%    IEEE Conference on Computer Vision and Pattern Recognition, pp.430-436, 2005.
clc, clear all, close all;

I = imread('images/S3.jpg');
if size(I, 3) > 1
    I = rgb2gray(I);
end
I = double(I);

%% Coefficient setting
maxIter = 50;    % Maximum count of iteration process. 
mu = 1;          % Coefficient of data term.
epsilon = 1;
nu = 1;          % Coefficient of penalty term with respect to level set function,
% used to make sure the updated level set function can be close enough to
% signal distance function.  
timeStep = .1;   % Time step.
c0 = 2;
bins = 12;
windowsize = 15;      % Window size during computing Spectrum histograms.
% Note: a higher window-size indicates a more smooth segmentation result.

% Initialize signed distance function phi. 
initLSF = ones(size(I)).*c0;
[row, col] = size(I);
initLSF(:, floor(col/3)) = -c0;
initLSF(:, floor(col*2/3)) = -c0;
initLSF(floor(row/3), :) = -c0;
initLSF(floor(row*2/3), :) = -c0;
phi = initLSF;

% Show input image and initial contour.
subplot(1, 2, 1), imshow(I, []);
hold on, contour(phi, [0 0], 'r', 'linewidth', 2);
% In this project, evolving contour is considerd as the zero level set of
% signed distance function phi. 
title('Input image');
hold off;

%% Compute texture features using spectrul histograms [1]
F = compFeaturemaps(I);
H = compHistogram(F, windowsize, bins); 
H = double(H);

%% Drive active contour move towards true region boundaries by 
%  updating level set function phi. 
for i = 1:maxIter
    phi = Evolution(phi, H, mu, nu, timeStep, epsilon);
    
    % Show current active contour every 5 iterations
    if mod(i, 5) == 0 || i == 1
        pause(.1);
        subplot(1, 2, 2), imshow(I, []), hold on;
        contour(phi, [0 0], 'r', 'linewidth', 2);
  
        % Display the iteration number. 
        iterNum=[num2str(i), ' iterations'];
        title(iterNum);
        hold off;
    end
end

