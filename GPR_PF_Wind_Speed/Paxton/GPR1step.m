function [ futurespeed ] = GPR1step( pastspeed, Xtrain, Ytrain )
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
hyp1.mean=[0.8652; 0.075; 0.0023; 0.6933];
hyp1.cov=[5.9353; -7.7508];
hyp1.lik=-0.6954;

[futurespeed, ~] = gp(hyp1, @infExact, meanfunc, covfunc, likfunc, Xtrain, Ytrain, pastspeed);

end

