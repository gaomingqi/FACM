function [Ig]=subImg(I,varargin)
% subImg(I,f1,f2,f3,...) applies fitlers fi to image I 
% Ig is an N1*N2*bn array containing bn filter responses
[N1,N2]=size(I);
I=double(I);
bn=length(varargin);
Ig=zeros(N1,N2,bn,'single');

for i=1:bn
    h=varargin{i};
    Ig(:,:,i) = single(imfilter(I,h,'symmetric'));
end

