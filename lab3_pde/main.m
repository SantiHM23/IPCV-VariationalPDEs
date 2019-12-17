%% Load the image and predefined values, and create the Mask
close all;
%clear all; 
clc;

Image=double(imread('eight.tif'));
mask=roipoly(Image/255.);
c1 = 110;
c2 = 227;
tau = 0.1;
epsilon = 1;
K = 1000;
lambda = 0.0001;
mu = 0.5;
n = 10;
sigma = 1/4;
tau_df = 1/2;
theta = 0;
theta_acc = 1;
thres = 0.175; %Obtained experimentally by trial and error

%% Implementation 1. Chan-Vese

t1 = cputime;
% Initialize the signed distance function
phi = signed_distance_from_mask(mask);

% Implement the Chan-Vese algorithm. The energy is computed inside this function
[phi, loss_m1, k, diff] = chanvese(Image, phi, epsilon, K, lambda, n, thres);

% Display the image
figure();
u=phi>0;
imagesc(Image);
colormap gray
hold on
contour(u,'r','Linewidth',3);

% Display the loss function
figure();
plot(loss_m1(:,1),loss_m1(:,2))

finaltime1 = cputime-t1;
%% Implementation 2. Chan, Esedoglu and Nikolova convex formulation

t2 = cputime;
% If desired, test with different masks
%mask = Image*0;  %%%%Not sensible to initialization of u (the mask)
%mask = rand(size(Image))>0.5;

%Smaller lambda in order to avoid noise inside the image
lambda = 0.00001;

% Implement the convex formulation. The energy is computed inside this function
[uk, loss_m2] = projected_gradient_descent(Image, mask, tau, lambda, c1, c2, epsilon, K);
ustar = uk-mu;
umu = Heavyside_eta(ustar, epsilon);

% Display the image
figure();
imagesc(Image);
colormap gray
hold on
contour(umu,'r','Linewidth',3);

% Display the loss function
figure();
plot(loss_m2(:,1),loss_m2(:,2))
 
finaltime2 = cputime-t2;
%% Implementation 3. Dual Formulation of the Total Variation

t3 = cputime;
% Initialize specific values for this implementation 
z = mask * 0;
%z = rand(size(Image))>0.5;

% Compute the Dual Formulation. The energy is computed inside this function
[u_df, loss_m3] = dual_formulation(z, mask, Image, c1, c2, sigma, tau_df, K, lambda, theta);

% Display the image
figure();
imagesc(Image);
colormap gray
hold on
contour(u_df,'r','Linewidth',3);

% Display the loss function
figure();
plot(loss_m3(:,1),loss_m3(:,2))

finaltime3 = cputime-t3;
%% Implementation 4. Acceleration

t4 = cputime;

% Initialize specific values for this implementation
%z = mask * 0;
z = rand(size(Image))>0.5;

% Perform the Chambolle-Pock acceleration. The energy is computed inside this function
[u_acc, loss_m4] = dual_formulation(z, mask, Image, c1, c2, sigma, tau_df, K, lambda, theta_acc);

% Display the image
figure();
imagesc(Image);
colormap gray
hold on
contour(u_acc,'r','Linewidth',3);

% Display the loss function
figure();
plot(loss_m4(:,1),loss_m4(:,2))

finaltime4 = cputime-t4;
%% Implementation 5. Active Contours

im = imread('tp3_e5.png');
im = rgb2gray(im);
im = double(im);
K = 100;
u = zeros(size(im));
c = 0.0001;
tau = 0.1;

for k = 1:K
    graI = div(gradx(im) , grady(im));
    graU = div(gradx(u) , grady(u));
    g = 1./(1+(graI).^2);
    kappa = div(gradx(u)./graU, grady(u)./graU);
    dudt = g .* (graU) .* (kappa + c);
    u = u + tau .* dudt;
    if mod(k,10) == 0
        u = fast_marching(u>0);
    end
end

figure();
imagesc(im);
colormap gray
hold on
contour(u,'r','Linewidth',3);

