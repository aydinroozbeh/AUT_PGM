% Aydin Roozbeh - 9931303 - PGM HW1 Part A and B - SUPERPIXEL

close all;
clear;
clc;

% Loading The image and converting it
im=imread("test1.bmp"); % Loading the image
im_db = im2double(im);  % Converting the uint8 to double

% Since creating superpixels almost acts as a low-pass filter and filters
% gaussian noise, we consider two cases
% Case 1: We add noise and then superpixelize the image
% Case 2: We superpixelize the image and then add noise

% ================================ CASE 1 =================================  

% We will consider three lables: 1 for white , 2 for gray, 3 for black
colors = [1 0.5 0]; % [1=White , 0.5=Gray , 0=Black]

% Total number of pixels in the image
pix = size(im_db,1)*size(im_db,2); 

%  *** if we ignore the distribution of colors => thresholds are at the
%  middle, We are assuming uniform a priori distribution for colors. ***
th_unif = [(colors(1) + colors(2))/2 , (colors(2) + colors(3))/2];

% Original Labeling, without noise, used later for comparison
im_gray = rgb2gray(im_db);
actual_label = image_to_label(im_gray,th_unif);

% Generating Random Noise with variance = (std)^2
% std = Standard Deviation
std = [0.001 , 0.1 ,0.3];
reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise1 = std(1)*randn(size(im_db));

reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise2 = std(2)*randn(size(im_db));

reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise3 = std(3)*randn(size(im_db));

% Noisy Images
im_noisy_1 = im_db + noise1; 
im_noisy_2 = im_db + noise2; 
im_noisy_3 = im_db + noise3; 

% Superpixelizing the images
n=50;
im_spn_1 = rgb2gray(get_superpixeled(im_noisy_1 , n));
im_spn_2 = rgb2gray(get_superpixeled(im_noisy_2 , n));
im_spn_3 = rgb2gray(get_superpixeled(im_noisy_3 , n));


% Plotting the superpixelized noisy images:
figure(1)
hold on;
subplot(1,3,1);
imshow(im_spn_1);
title("Superpixelized after nosie 1");

subplot(1,3,2);
imshow(im_spn_2);
title("Superpixelized after nosie 2");

subplot(1,3,3);
imshow(im_spn_3);
title("Superpixelized after nosie 3");

% Noisy labels (acquired from noisy images)
noisy_label_1 = image_to_label(im_spn_1,th_unif);
noisy_label_2 = image_to_label(im_spn_2,th_unif);
noisy_label_3 = image_to_label(im_spn_3,th_unif);

% Measuring the accuracy of labeling in presence of noise
acc1 = 100*get_accuracy(actual_label , noisy_label_1);
acc2 = 100*get_accuracy(actual_label , noisy_label_2);
acc3 = 100*get_accuracy(actual_label , noisy_label_3);

disp("ACCURACY IN CASE 1:");
disp(acc1);
disp(acc2);
disp(acc3);

% =============================== CASE 2 ==================================
clear;

im=imread("test1.bmp"); % Loading the image
im_db = im2double(im);  % Converting the uint8 to double
colors = [1 0.5 0]; % [1=White , 0.5=Gray , 0=Black]
th_unif = [(colors(1) + colors(2))/2 , (colors(2) + colors(3))/2];
im_gray = rgb2gray(im_db);
actual_label = image_to_label(im_gray,th_unif);



% Superpixelizing
n=40;
im_sp = rgb2gray(get_superpixeled(im_db , n));

figure(2);
imshow(im_sp);
title("Superpixelized at first");

% Generating Random Noise with variance = (std)^2
% std = Standard Deviation
std = [0.001 , 0.1 ,0.3];
reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise1 = std(1)*randn(size(im_sp));

reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise2 = std(2)*randn(size(im_sp));

reset(RandStream.getGlobalStream,sum(100*clock)); % new seed for random number generator
noise3 = std(3)*randn(size(im_sp));

% Noisy images
im_nsp_1 = im_sp + noise1;
im_nsp_2 = im_sp + noise2;
im_nsp_3 = im_sp + noise3;

% Noisy labels (acquired from noisy images)
noisy_label_1 = image_to_label(im_nsp_1,th_unif);
noisy_label_2 = image_to_label(im_nsp_2,th_unif);
noisy_label_3 = image_to_label(im_nsp_3,th_unif);

% Reconstructing the image using the noisy labels
noisy_image_1 = label_to_image(noisy_label_1);
noisy_image_2 = label_to_image(noisy_label_2);
noisy_image_3 = label_to_image(noisy_label_3);

% Measuring the accuracy of labeling in presence of noise
acc1 = 100*get_accuracy(actual_label , noisy_label_1);
acc2 = 100*get_accuracy(actual_label , noisy_label_2);
acc3 = 100*get_accuracy(actual_label , noisy_label_3);

disp("ACCURACY IN CASE 2:");
disp(acc1);
disp(acc2);
disp(acc3);


figure(3)
subplot(2,3,1);
imshow(im_nsp_1);
title("Noise 1");

subplot(2,3,4);
imshow(noisy_image_1);
title("Labeled 1");

subplot(2,3,2);
imshow(im_nsp_2);
title("Noise 2");

subplot(2,3,5);
imshow(noisy_image_2);
title("Labeled 2");

subplot(2,3,3);
imshow(im_nsp_1);
title("Noise 3");

subplot(2,3,6);
imshow(noisy_image_3);
title("Labeled 3");