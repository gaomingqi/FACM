% This function can be used to drive active contour to move towards true 
% region boundaries by updating level set function
function phi = Evolution(phi, H, mu, nu, timeStep, epsilon)
phi = NeumannBoundCond(phi);
K = curvature_central(phi);     % compute curvature of active contours

% Compute dirac function in Equation (13) 
D = (epsilon/pi)./(epsilon^2.+phi.^2);

% Differentiate between feature histograms of each region in matrix H
idx1 = find(phi <= 0);
idx2 = find(phi > 0);
% Classify different regions using zero level set of phi
H1 = H(:, idx1);
H2 = H(:, idx2);
% Note: Compared with original ideas in our paper, there are differences
% in some aspects. To improve computational efficiency, 
% representative features are computed directly from feature histograms.
R1 = sum(H1, 2) / (length(idx1) + eps);
R2 = sum(H2, 2) / (length(idx2) + eps);

% Construct the representative feature matrix of input texture image
R = [R1, R2];

% Compute combination weights according to the known matrix H and matrix R
W = max(0, (R'*R+eye(2)*0.1) \ (R'*H) ); % Equation (9)
W = W';
    
% Divide data energy terms from matrix W. 
wo = reshape(W(:, 1), size(phi, 1), size(phi, 2));
wb = reshape(W(:, 2), size(phi, 1), size(phi, 2));

% Compute data force.
dataForce = mu*(wo - wb);    
dataForce = dataForce.*200;  % Coefficient 200 is used to enhance the 
% influence of data force in energy functional.

% Update level set function. 
A = -D.*dataForce;                  % 1st term in Equation (13)
P = nu*(4*del2(phi)-K);             % 2nd term in Equation (13), where 4*del2(u) computes the laplacian (d^2u/dx^2 + d^2u/dy^2)
phi = phi + timeStep*(P+A);         % Equation (14)


% Other function definitions. 
function g = NeumannBoundCond(f)
% Neumann boundary condition
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);  
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);          
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);  

function k = curvature_central(u)                       
% Compute curvature
[ux,uy] = gradient(u);                                  
normDu = sqrt(ux.^2+uy.^2+1e-10);       % The norm of the gradient plus a small possitive number 
                                        % to avoid division by zero in the following computation.
Nx = ux./normDu;                                       
Ny = uy./normDu;
[nxx,junk] = gradient(Nx);                              
[junk,nyy] = gradient(Ny);                              
k = nxx+nyy;                           	% Compute divergence