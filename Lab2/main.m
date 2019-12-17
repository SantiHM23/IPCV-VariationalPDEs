%% Loading an Image and cnverting it in gray scale
clc;  clear all; close all;
disp('Loading an Image and converting it in gray scale');
%Im_data=imread('lena512.bmp');
Im_data=imread('cameraman.tif');
%Im_data=imread('roberto.jpg');
figure('Name','Original Image');
imshow(Im_data);
if size(Im_data,3)==3
    Im_data=rgb2gray(Im_data);
end
Im_data=double(Im_data);
figure('Name','Gray Scale Image');
imshow(Im_data/255.);

%% Adding Gaussian Noise
disp('Adding Gaussian Noise');
Im_noised=add_gaussian_noise(Im_data,30);
figure('Name','Image with Gaussian Noise');
imshow(Im_noised/255.);

%% Denoise Tikhonov and Denoise TV
disp('Denoise Tikhonov and Denoise TV');
K=300;
eps=1;
tao=0.1;
for lambda=[1 0.1 0.01 0.001]
    uktk=Denoise_Tikhonov(Im_noised,K,lambda);
    figureTitle = sprintf('Deniosing with Denoise_Tikhonov at lambda=%d',lambda);
    figure('Name',figureTitle);
    imshow(uktk/255.);
    uktv=Denoise_TV(Im_noised,tao,K,lambda,eps);
    figureTitle = sprintf('Deniosing with Denoise_TV at lambda=%d',lambda);
    figure('Name',figureTitle);
    imshow(uktv/255.);
end

%% Finding the minimizer using functions fft2 and ifft2
disp('Finding the minimizer using functions fft2 and ifft2');
% K=300;
% eps=1;
% tao=0.1;
% for lambda=[1 0.1 0.01 0.001]
%     uktk=Denoise_Tikhonov(Im_noised,K,lambda);
%     figureTitle = sprintf('Deniosing with Denoise_Tikhonov at lambda=%d',lambda);
%     figure('Name',figureTitle);
%     imshow(uktk/255.);
% end

%% Variational models and minimization: Deconvolution

G= fspecial('gaussian', [7 7], 5);
disp('Loading an Image and converting it in gray scale');
Im_data=imread('Im1.png'); 
%Im_data=imread('cameraman.tif');
mask_data=imread('Im1_mask.png');
mask_data=double(mask_data);
figure('Name','Original Image');
imshow(Im_data);
if size(Im_data,3)==3
    Im_data=rgb2gray(Im_data);
end
Im_data=double(Im_data);
figure('Name','Gray Scale Image');
imshow(Im_data/255.);
Img_Conv=conv2(Im_data,G,'same');
figure('Name','Convolved Image');
imshow(Img_Conv/255.);


% Adding Gaussian Noise
disp('Adding Gaussian Noise with the Convolved image');
Img_Conv_noised=add_gaussian_noise(Img_Conv,30);
figure('Name','Image with Gaussian Noise');
imshow(Img_Conv_noised/255.);
disp('Deconvolution TV');
K=300;
eps=0.01;
tao=0.1;
for lambda=0.1%[1 0.1 0.01 0.001]
%     uktk=Deconvolution_TV(Img_Conv_noised,G,tao,eps,K,lambda);
%     figureTitle = sprintf('Deconvolution TV at lambda=%d',lambda);
%     figure('Name',figureTitle);
%     imshow(uktk/255.);
%     imagesc(uktk);
%     colormap gray;
    
    InTV=Inpainting_TV(Im_data,mask_data,tao,eps,K,lambda);
    figureTitle = sprintf('Inpainting_TV at lambda=%d',lambda);
    figure('Name',figureTitle);
    imshow(InTV/255.);
end
