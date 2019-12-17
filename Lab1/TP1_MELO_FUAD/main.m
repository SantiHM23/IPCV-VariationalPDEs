%% Loading an Image and cnverting it in gray scale
clc;  clear all; close all;
disp('Loading an Image and cnverting it in gray scale');
%Im_data=imread('lena512.bmp');
%Im_data=imread('cameraman.tif');
Im_data=imread('roberto.jpg');
figure('Name','Original Image');
imshow(Im_data);
if size(Im_data,3)==3
    Im_data=rgb2gray(Im_data);
end
Im_data=double(Im_data);
figure('Name','Gray Scale Image');
imshow(Im_data/255.);
disp('Image Loaded');
%% Adding Gaussian Noise
disp('Adding Gaussian Noise');
Im_noised=add_gaussian_noise(Im_data,30);
figure('Name','Image with Gaussian Noise');
imshow(Im_noised/255.);
disp('Gaussian Noise Added');
%% Comparison of Noise Recovery between Heat Equation and convolutional gaussian kernel
disp('Comparing Noise Recovery between Heat Equation and convolutional gaussian kernel');
dt = 1/8;
ct = 1;
for K = [1 20 40 60 80 100]
    %Noise recovery with heat equation
    I_ht = heat_equation(Im_noised, dt, K);
    figureTitle = sprintf('Noise recovery with heat equation at K=%d',K);
    figure('Name',figureTitle);
    imshow(I_ht/255.);
    %Noise recovery with convolutional gaussian kernel
    I_cgk = conv_gauss_krnl(Im_noised, dt, K);
    figureTitle = sprintf('Noise recovery with convolutional gaussian kernel at K=%d',K);
    figure('Name',figureTitle);
    imshow(I_cgk/255.);
    %Difference between both methods
    Imdiff(ct) = (sum(sum(abs(I_ht - I_cgk))))/(size(I_ht,1)*size(I_ht,1));
    ct = ct+1;
end
disp('Comparison Step done');
%% Obtaining Contour Image using Marr Hildreth on Noisy image and Denoised Image
disp('Obtaining Contour Image using Marr Hildreth on Noisy image and Denoised Image');
dt = 1/8;
K = 20;
mu = 12;

% Contour of Noised image using Marr Hildreth
Inoise_edges = Marr_Hildreth(Im_noised, mu);
figureTitle = sprintf('Contour: Marr-Hildreth on Noisy image at mu=%d',mu);
figure('Name',figureTitle);
imshow(Inoise_edges);

%Denoising of the image using Heat Equation
I_ht = heat_equation(Im_noised, dt, K);
%Obtention of the edges of the image
I_ht_edges = Marr_Hildreth(I_ht, mu);
figureTitle = sprintf('Contour: Marr-Hildreth on Heat Eq. Denoised mu=%d',mu);
figure('Name',figureTitle);
imshow(I_ht_edges);

%Denoising of the image using Gaussian Convolution
Im_cgk = conv_gauss_krnl(Im_noised, dt, K);
%Obtention of the edges of the image
ICG_edges = Marr_Hildreth(Im_cgk, mu);
figureTitle = sprintf('Contour Marr Hildreth GaussConv. Denoised mu=%d',mu);
figure('Name',figureTitle);
imshow(ICG_edges);
disp('Countour Step done');
%% Perona Malik: Denoising of the image with Perona Malik algorithm
disp('Perona Malik: Denoising of the image with Perona Malik algorithm');
dt = 1/8;
K = 80;
mu = 2;
alpha = 15;

%Denoising of the image with Perona Malik algorithm
I_pm = Perona_Malik(Im_noised, dt, K, alpha);
figureTitle = sprintf('Denoising image with Perona Malik at K=%d, mu=%d, alpha=%d',K,mu,alpha);
figure('Name',figureTitle);
imshow(I_pm/255.);

%Obtention of the edges of the image
Imh_edges = Marr_Hildreth(I_pm, mu);
figureTitle = sprintf('Obtaining edges of Denoised image with Perona Malik');
figure('Name',figureTitle);
imshow(Imh_edges);
disp('Perona Malik step done');

%% Perona Malik Enhacement with a convolution of the gradient with a Gaussian
disp('Perona Malik Enhacement with a convolution of the gradient with a Gaussian');
dt = 1/8;
mu = 4;
alpha = 15;
for K = [20,80]
    %Denoising of the image with Perona Malik algorithm
    Ipmk = Perona_Malik(Im_noised, dt, K, alpha);
    figureTitle = sprintf('Denoising with Perona Malik at K=%d, mu=%d, alpha=%d',K,mu,alpha);
    figure('Name',figureTitle);
    imshow(Ipmk/255.);
    
    %Obtention of the edges of the image with Perona Malik algorithm
    I_edges_K = Marr_Hildreth(Ipmk, mu);
    figureTitle = sprintf('Obtaining edges of Denoised with Perona Malik at K=%d',K);
    figure('Name',figureTitle);
    imshow(I_edges_K);

    %Denoising of the image with Perona Malik Enhacement with a convolution of the gradient with a Gaussian
    Ipmg = Perona_Malik_Gaussian(Im_noised, dt, K, alpha);
    figureTitle = sprintf('Denoising img Perona Malik Gaussian at K=%d, mu=%d, alpha=%d',K,mu,alpha);
    figure('Name',figureTitle);
    imshow(Ipmg/255.);

    %Obtention of the edges of the image with Perona Malik Enhacement with a convolution of the gradient with a Gaussian
    I_edges_g = Marr_Hildreth(Ipmg, mu);
    figureTitle = sprintf('Edges of Denoised Perona Malik Gaussianat K=%d',K);
    figure('Name',figureTitle);
    imshow(I_edges_g);
end
disp('Perona Malik with Enhancement step done!');
disp('Simulation Complete!');
    
