% Aydin Roozbeh - 9931303 - PGM HW1 - 

close all;
clear;
clc;
format long

% Loading The image and converting it
im=imread("test1.bmp"); % Loading the image
im_db = im2double(im);  % Converting the uint8 to double

% converting image to grayscale, hence we only have exposure levels
im_gray = rgb2gray(im_db);

% We will consider three lables: 1 for white , 2 for gray, 3 for black
colors=[1 0.5 0];

% --- Extracting Colors in the picture ---
pix = (size(im_gray,1)-1)*size(im_gray,2); % Total number of pixels in the image


% Threshould levels, assumiung uniform a priori distribution
th_unif = [(colors(1) + colors(2))/2 , (colors(2) + colors(3))/2];

% Original Label of each pixel
ref_label = image_to_label(im_gray,th_unif);



% ============================= Part C & D ================================

beta  = -20;    % beta parameter in the formula
num_n = 8;      % Number of Neighbors
std   = 0.1 ;      % noise standard deviation

% Creating noisy image:
ref_image = im_gray + randn(size(im_gray))*std;

current_state = image_to_label(ref_image,th_unif);

current_energy = sim_ann_cost(current_state, ref_image, std, beta, num_n);

% Remembering how it all started, for comparison at the end of the run
initial_energy = current_energy;
initial_state = current_state;
initial_accuracy = get_accuracy(current_state , ref_label);

% Initial Temperature
T = pix; a=0.9999;

% Counting the number of iteraions
count=0;

% Neighbor state = a state with only one different label, chosen randomly!

% ------------------------ Simulated Annealing ----------------------------
while(T>1)
    temp_state  = new_state(current_state,count); % A random new state

    % Generating the difference in energy due to transition to a new state
    delta_energy = get_delta_energy(ref_image, current_state , temp_state, count, std, beta, num_n);

    if(delta_energy < 0)
        disp("ALERT!!!");
        current_state  = temp_state;
        current_energy = current_energy + delta_energy;
    
    else
        r = 100000*rand(1,1);  
        if(r < exp(-delta_energy/T) )
            disp("!!!!!!!! ALERT !!!!!!!1!!!");
            current_state=temp_state;
            current_energy=current_energy + delta_energy;
        end
    end
    T=T-1; % Cooling Down...
    count=count+1;

end
% -------------------------------------------------------------------------

% For comparison, we define:
final_energy = current_energy;
final_state = current_state;
final_accuracy = get_accuracy(final_state , ref_label);

figure(1);
subplot(1,2,1);
title("Initial");
imshow(label_to_image(initial_state));
    
subplot(1,2,2);
title("Final")
imshow(label_to_image(final_state));

disp("Final Accuracy: ")
disp(final_accuracy);