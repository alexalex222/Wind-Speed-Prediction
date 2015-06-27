function [ futurespeed ] = GPR3step( pastspeed, Xtrain, Ytrain )
%The trainded GPR model for 1-step-ahaed wind speed prediction
%   the past wind speed is vector
%   the future is a scalar



hyp.cov=[0;0];
hyp.mean = [0;0;0;0];
covfunc = @covSEiso; 
likfunc = @likGauss; 
hyp.lik = log(0.1);
meanfunc = {@meanSum, {@meanLinear, @meanConst}};

% hyp1 = minimize(hyp, @gp, -500, @infExact, meanfunc, covfunc, likfunc, Xtrain1(:,:), Ytrain);
hyp3.mean=[0.8004;0.157;-0.0531;1.1273];
hyp3.cov=[5.9353; -7.7508];
hyp3.lik=-0.2207;

[futurespeed, ~] = gp(hyp3, @infExact, meanfunc, covfunc, likfunc, Xtrain, Ytrain, pastspeed);

end

