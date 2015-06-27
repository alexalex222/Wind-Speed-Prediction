clear;clc
load example_data
%load example2_data

% getting the data size information 
%(N = number of data samples, d = dimesions)
[N,d] = size(example_data);

% Defining the mixture model parameters
K = 3; % Number of models
num_bins =  2^12;  % needed for non-parametric marginal density estimation
num_GD_iterations = 100; % Max number of Grqadient Descent iteration

% Obtaining the CDF values by fitting the marginal densities.
u = GMCM_marginals_learning(example_data,d,num_bins);
 
% Creating a Gaussian Copula Mixture (gmc) object
gmcObject = gmcdistribution([],[],[]);

% Estimating the paramters with the default options.
gmcObject_bestfit = gmcObject.fit(u,K,d,N);


% scatter plot of the data overlayed with the contours of fitted
% probability density values
figure;count = 1;
for i = 1:d
    for j = 1:d
        subplot(d,d,count); count = count+1;    
        biVariateContourPlotsGMMCopula(example_data,gmcObject_bestfit,0,256,i,j);        
    end
end








