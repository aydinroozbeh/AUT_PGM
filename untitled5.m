% Aydin Roozbeh - 9931303 - PGM HW1 - 

close all;
clear;
clc;
format long

% Loading The image and converting it
im=imread("test2.jpg"); % Loading the image
im_db = im2double(im); 

im_hsv = rgb2hsv(im_db);
im_hue=im_hsv(:,:,2);
imshow(im_hue)