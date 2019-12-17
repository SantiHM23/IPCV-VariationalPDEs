clc;  clear all; close all;
%load the image camerama.tif that is included in MATLAB's own dataset:
Im_data=imread('cameraman.tif');
%VERY IMPORTANT: do not forget to convert integer values
%in real ones for future manipulations:
Im_data=double(Im_data);
%Display:
imagesc(Im_data);
colormap gray;
%To open a second figure:
figure;
%Other command for image display:
imshow(Im_data/255.);
%If the image has real values, imshow require these values to be
%in the range [0;1] for a correct display. A normalization is thus
%required if working in the range [0;255]