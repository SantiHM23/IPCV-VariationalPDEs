clc;  clear all; close all;

Im_data=imread('cameraman.tif');

Im_data=double(Im_data);


Im_noised=add_gaussian_noise(Im_data,30);
imagesc(Im_data);
colormap gray;
imagesc(Im_noised);
colormap gray;

