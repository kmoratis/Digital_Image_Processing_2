% Demo script for demonstrating the use of descriptorMatching function.

close all;
clc;

% Read the images and convert them to grayscale if not already
im1 = imread('imForest1.png');
im2 = imread('imForest2.png');

% Get the size of the image
[~, ~, numberOfColors] = size(im1);

% If the image is RGB, convert it to grayscale
if numberOfColors > 1
    im1 = rgb2gray(im1);
end 

% Get the size of the image
[~, ~, numberOfColors] = size(im2);

% If the image is RGB, convert it to grayscale
if numberOfColors > 1
    im2 = rgb2gray(im2);
end

% Harris Detector parameters
sigma = 2.5; % Gaussian smoothing parameter 
threshold = 5e+5; % Threshold 
k = 0.24; % Harris k constant 
show_im = false; % Parameter for img display

% Detect corner points for image 1
points_1 = myDetectHarrisFeatures(im1, sigma, k, threshold, show_im);

% Detect corner points for image 2
points_2 = myDetectHarrisFeatures(im2, sigma, k, threshold, show_im);

% Descriptor parameters
rhom = 2; % Min rad
rhoM = 12; % Max rad
rhostep = 1; % Rad step
N = 40; % Number of points

desc_upgrade = false; % which version of the descriptor to use

% Calc descriptor vector size
s = 1 + (rhoM - rhom) / rhostep;

% Create array to store actual corner points ( descriptor not empty )
cor_1 = zeros(size(points_1));
cor1_found = 0;

% Create array to store im1 descriptors
N1 = size(points_1, 1);
desc1 = zeros(s, N1);

% Calculate im1 corners descriptors
for i = 1:N1
    p = points_1(i, :);

    if desc_upgrade == true % use desc_upgrade verion of the descriptor
        d = myLocalDescriptorUpgrade(im1, p, rhom, rhoM, rhostep, N);
        if ~isempty(d) && sum(d)~=0 % if descriptor is not empty vector
            cor1_found = cor1_found + 1;
            desc1(:, cor1_found) = d(:);
            cor_1(cor1_found, :) = p;
        end
    else
        d = myLocalDescriptor(im1, p, rhom, rhoM, rhostep, N);
        if ~isempty(d) && sum(d)~=0 % if descriptor is not empty vector
            cor1_found = cor1_found + 1;
            desc1(:, cor1_found) = d(:);
            cor_1(cor1_found, :) = p;
        end
    end
end

% keep the usefull part of the array
cor_1 = cor_1(1:cor1_found, :);
desc1 = desc1(:, 1:cor1_found);

% Create array to store actual corner points ( descriptor not empty )
cor_2 = zeros(size(points_2));
cor2_found = 0;

% Create array to store im2 descriptors
N2 = size(points_2, 1);
desc2 = zeros(s, N2);

% Calculate im2 corners descriptors
for i = 1:N2
    p = points_2(i, :);

    if desc_upgrade == true % use desc_upgrade verion of the descriptor
        d = myLocalDescriptorUpgrade(im2, p, rhom, rhoM, rhostep, N);
        if ~isempty(d) && sum(d)~=0 % if descriptor is not empty vector
            cor2_found = cor2_found + 1;
            desc2(:, cor2_found) = d(:);
            cor_2(cor2_found, :) = p(1, :);
        end
    else
        d = myLocalDescriptor(im2, p, rhom, rhoM, rhostep, N);
        if ~isempty(d) && sum(d)~=0 % if descriptor is not empty vector
            cor2_found = cor2_found + 1;
            desc2(:, cor2_found) = d(:);
            cor_2(cor2_found, :) = p;
        end
    end
end

% keep the usefull part of the array
cor_2 = cor_2(1:cor2_found, :);
desc2 = desc2(:, 1:cor2_found);

% Perform the descriptor matching, by calling the appropriate function
percentageThreshold = 1e-4; % threshold for keeping only percentage of the points with the strongest simillarity
show_im_matching = true; % whether to show the images with the matching points or not

matchingPoints = descriptorMatching(desc1, desc2, percentageThreshold);
matchedPoints1 = cor_1(matchingPoints(1,:), :); % All matched [x, y] in image1
matchedPoints1 = matchedPoints1(:, [2 1]); % [x,y] -> [y,x]
matchedPoints2 = cor_2(matchingPoints(2,:), :); % All matched [x, y] in image2
matchedPoints2 = matchedPoints2(:, [2 1]);

% Visualize candidate matches
figure;
showMatchedFeatures(im1, im2, matchedPoints1, matchedPoints2, 'montage');
title('Candidate point matches');
legend('Matched points 1', 'Matched points 2');