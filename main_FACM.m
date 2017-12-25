% This project demonstrates the texture segmentation method in paper:
%   "A factorization based active contour model for texture segmentation", 
%   Mingqi Gao, Hengxin Chen, Shenhai Zheng, Bin Fang, 
%   IEEE International Conference on Image Processing (ICIP), 2016.
% Main References in our project: 
% [1] Yuan J, Wang D, Cheriyadat A M, 
%    "Factorization based Texture Segmentation",
%    IEEE Trans. Image Processing, vol. 24 (11), pp.3488-3497, 2015.
% [2] Li C, Xu C, Gui C, et al, 
%    "Level Set Evolution without Re-Initialization: A New Variational Formulation",
%    IEEE Conference on Computer Vision and Pattern Recognition, pp.430-436, 2005.
clc, clear all, close all;

u0 = imread('images/S2.jpg');
if size(u0, 3) > 1
    u0 = rgb2gray(u0);          % convert given image into grey-level
end
u0 = double(u0);

%% Coefficient setting
maxIter = 40;    % Maximum count of iteration process. 
mu = 1;          % Coefficient of fitting term.
epsilon = 1;
nu = 1;          % Coefficient of penalty term with respect to level set function,
% used to make sure the updated level set function can be close enough to
% signal distance function.  
timeStep = .1;   % Time step.
bins = 12;
windowsize = 20;      % Window size during computing Spectrum histograms.
% Note: a higher window-size indicates a more smooth segmentation result.

% initialize level set function or load a existing initial contour
%--- if you want initialize the active contour by Manual setting, please
%remove the following comments:
% m = roipoly;  % select a polygonal region by hand;
% phi = bwdist(m) - bwdist(1-m) + im2double(m) - .5;  % compute SDF according to m;
%--- Load existing initial contour
load('initial_contours/init_contour1.mat');  % circle contour
% load('initial contours/init_contour2.mat');    % 9 even-distributed retangle contours
phi = imresize(phi, size(u0));
phi = double(phi);

% Show input image and initial contour.
subplot(1, 2, 1), imshow(u0, []);
hold on, contour(phi, [0.5 0.5], 'r', 'linewidth', 2);
% In this project, evolving contour is considerd as the zero level set of
% signed distance function phi. 
title('Given image');
hold off;

%% Compute texture features using spectrul histograms [1]
F = compFeaturemaps(u0);            % compute feature maps from given image
H = compHistograms(F, windowsize);  % compute feature histograms of each pixel within fixed window
H = double(H);                      

%% Drive active contour move towards true region boundaries by 
%  updating level set function phi. 
for i = 1:maxIter
    phi = Evolution(phi, H, mu, nu, timeStep, epsilon);
    
    % Show current active contour every 5 iterations
    if mod(i, 5) == 0 || i == 1
        pause(.1);
        subplot(1, 2, 2), imshow(u0, []), hold on;
        contour(phi, [0 0], 'r', 'linewidth', 2);
  
        % Display the iteration number. 
        iterNum=[num2str(i), ' iterations'];
        title(iterNum);
        hold off;
%--- if you want to save the segmentation process as a GIF file, please
%    remove the following comments:
%         frame = getframe(gcf);
%         im = frame2im(frame);   % extract image from current figure;
%         [I, map] = rgb2ind(im,256);
% 
%         if i==1;
%              imwrite(I, map, 'results/evo_process.gif', 'gif', 'Loopcount', inf,...
%                  'DelayTime', 0.3);  % initialize GIF file;
%         else
%             imwrite(I, map, 'results/evo_process.gif', 'gif', 'WriteMode', 'append',...
%                 'DelayTime', 0.2);  % add new frame every each 5 iterations;
%         end
%--- 
    end
end

%% save the mask of segmentation result;
Iseg = zeros(size(phi));
Iseg(phi > 0) = 1;
imwrite(Iseg, 'results/seg_result.jpg');

disp('end of FACM seg program');