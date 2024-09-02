% Aydin Roozbeh - 9931303 - PGM HW1 Part A and B

close all;
clear;
clc;

% Loading The image and converting it
im=imread("test1.bmp"); % Loading the image
im_db = im2double(im);  % Converting the uint8 to double
clear im;
% converting image to grayscale, hence we only have exposure levels
im_gray = rgb2gray(im_db);  

% We will consider three lables: 1 for white , 2 for gray, 3 for black

pix = size(im_gray,1)*size(im_gray,2); % Total number of pixels in the image

colors = [1 0.5 0]; % [1=White , 0.5=Gray , 0=Black]

%============================== Part A & B ================================

%  *** if we ignore the distribution of colors => thresholds are at the
%  middle, We are assuming uniform a priori distribution for colors. ***
th_unif = [(colors(1) + colors(2))/2 , (colors(2) + colors(3))/2];

% Original Labeling, without noise, used later for comparison
actual_label = image_to_label(im_gray,th_unif);

% Generating Random Noise with variance = (std)^2
% std = Standard Deviation
std = [0.01 , 0.1 ,0.3];
reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise1 = std(1)*randn(size(im_gray));

reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise2 = std(2)*randn(size(im_gray));

reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise3 = std(3)*randn(size(im_gray));

% Noisy Images
im_noisy_1 = im_gray + noise1; 
im_noisy_2 = im_gray + noise2;  
im_noisy_3 = im_gray + noise3; 

% Noisy labels (acquired from noisy images)
noisy_label_1 = image_to_label(im_noisy_1,th_unif);
noisy_label_2 = image_to_label(im_noisy_2,th_unif);
noisy_label_3 = image_to_label(im_noisy_3,th_unif);

% Measuring the accuracy of labeling in presence of noise
acc1 = 100*get_accuracy(actual_label , noisy_label_1);
acc2 = 100*get_accuracy(actual_label , noisy_label_2);
acc3 = 100*get_accuracy(actual_label , noisy_label_3);

% Reconstructing the image using the noisy labels
noisy_image_1 = label_to_image(noisy_label_1);
noisy_image_2 = label_to_image(noisy_label_2);
noisy_image_3 = label_to_image(noisy_label_3);

% Dipslaying the accuracy 
disp("Accuracy for different noise level are respectively (%):");
disp(acc1);
disp(acc2);
disp(acc3);

% Plotting the reconstructed images
figure(1)
subplot(3,3,1); % Noise 1 -------
hold on;
title("Original Image");
imshow(im_gray);

subplot(3,3,2);
hold on;
title("Image with Noise 1");
imshow(im_noisy_1)

subplot(3,3,3)
hold on;
title("Reconstructed image");
imshow(noisy_image_1);

subplot(3,3,4); % Noise 2 ------
title("Original Image");
hold on;
imshow(im_gray);

subplot(3,3,5);
hold on;
title("Image with Noise 2");
imshow(im_noisy_2)

subplot(3,3,6)
hold on;
title("Reconstructed image");
imshow(noisy_image_2);

subplot(3,3,7); % Noise 3 ------
hold on;
title("Original Image");
imshow(im_gray);

subplot(3,3,8);
hold on;
title("Image with Noise 3");
imshow(im_noisy_3)

subplot(3,3,9)
hold on;
title("Reconstructed image");
imshow(noisy_image_3);
%==========================================================================


