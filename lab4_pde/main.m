%% Load the image
close all;
clear all; 
clc;

Im = rgb2gray(imread('roberto.jpg'));
%Im = imread('cameraman.tif');
Im = double(Im);
f = add_gaussian_noise(Im, 30);
u = f;

lambda = 0.01;
L = 0.01;
h = 1/(2*lambda);

%% Image restoration (Gaussian Noise)

z = zeros(size(u,1), size(u,2), 2);
restIteration = 100;

t1 = cputime;
restim = prox5(u, h, z, restIteration);
finalt1 = cputime - t1;

t2 = cputime;
restimfast = fista(u, h, z, restIteration);
finalt2 = cputime - t2;

figure()
imshow(f./255);
figure()
imshow(restim./255);
figure()
imshow(restimfast./255);

%% Image Deconvolution (Gaussian Noise)

z = zeros(size(u,1), size(u,2), 2);

K = fspecial('gaussian', [7 7], 0.5);
convolvedim = conv2(Im, K, 'same');
f = add_gaussian_noise(convolvedim, 30);
u = f; 
it1 = 100;
it2 = 10;
lambda = 0.03;
h = 1/(2*lambda);
    
t3 = cputime;
decvim = forwardbackward(u, h, z, f, lambda, K, it1, it2);
finalt3 = cputime-t3;

t4 = cputime;
decvimfist = forwardbackward_fista(u, h, z, f, lambda, K, it1, it2);
finalt4 = cputime-t4;

figure()
imshow(f./255);
figure()
imshow(decvim./255);
figure()
imshow(decvimfist./255);
%% Image Inpainting
close all;
clear all;
clc;

image=3; % s
 if image== 1
     Im = imread('Im1.png');
     Im = double(Im);
     mask = imread('Im1_mask.png');
     mask = double(mask)./255;
 elseif image == 2
     Im = imread('Im2.png');
     Im = double(Im);
     mask = imread('Im2_mask.png');
     mask = double(mask)./255;
 elseif image == 3
     Im = imread('Im3.png');
     Im = double(Im);
     mask = imread('Im3_mask.png');
     mask = double(mask)./255;
 end


z = zeros(size(Im,1), size(Im,2), 2);
lambda = 0.01;
h = 1/(2*lambda);
it1 = 100;
it2 = 10;

inpaintedimage = forwardbackward_inpainting(Im, h, z, lambda, mask, it1, it2);


figure()
imagesc(inpaintedimage./255);
colormap gray