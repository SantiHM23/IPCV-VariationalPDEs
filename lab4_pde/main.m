%% Load the image
close all;
clear all; 
clc;

Im = imread('cameraman.tif');
Im = double(Im);
f = add_gaussian_noise(Im, 30);
u = f;

lambda = 0.01;
L = 0.01;
h = 1/(2*lambda);

%% Image restoration (Gaussian Noise)

z = zeros(size(u,1), size(u,2), 2);

t1 = cputime;
restim = prox5(u, h, z);
finalt1 = cputime - t1;

t2 = cputime;
restimfast = fista(u, h, z);
finalt2 = cputime - t2;

figure()
imshow(f./255);
figure()
imshow(restim./255);
figure()
imshow(restimfast./255);

%% Image Deconvolution (Gaussian Noise)

z = zeros(size(u,1), size(u,2), 2);

K = fspecial('gaussian', [7 7], 5);
convolvedim = conv2(Im, K, 'same');
f = add_gaussian_noise(convolvedim, 30);
u = f; 

decvim = forwardbackward(u, h, z, f, lambda, K);

figure()
imshow(decvim./255);

%% Image Inpainting

Im = imread('Im1.png');
Im = double(Im);
% Im = imread('Im2.png');
% Im = double(Im);
% Im = imread('Im3.png');
% Im = double(Im);

mask = imread('Im1_mask.png');
mask = double(mask)./255;
% mask = imread('Im2_mask.png');
% mask = double(mask);
% mask = imread('Im3_mask.png');
% mask = double(mask);

z = zeros(size(Im,1), size(Im,2), 2);
lambda = 0.01;
h = 1/(2*lambda);

inpaintedimage = forwardbackward_inpainting(Im, h, z, lambda, mask);

figure()
imagesc(inpaintedimage./255);
colormap gray