%%% Modeler

clear all;
close all;
clc;

data = [];
load('denver_co.mat');
data = [data;Data(1:100,:)];
load('saltlakecity_ut.mat');
data = [data;Data(1:100,:)];
load('tucson_az.mat');
data = [data;Data(1:100,:)];
Data = data;

X = Data(:,1:end-1); y = Data(:,end);

data = [];
load('denver_co.mat');
data = [data;Data(101:200,:)];
load('saltlakecity_ut.mat');
data = [data;Data(101:200,:)];
load('tucson_az.mat');
data = [data;Data(101:200,:)];
Data_Test = data;

Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);

[label, model, llh] = emgm(X', 8);

covfunc = @covSEiso;
likfunc = @likGauss;
sn = 0.1;
hyp.lik = log(sn);
hyp2.cov = [0;0];
hyp2.lik = log(0.1);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X, y);
exp(hyp2.lik);
nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X, y);
[m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, X, y, Xs);

clc;

figure;
hold on;
f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
x = [1:length(m)];
fill([x'; flipdim(x',1)], f, [7 7 7]/8);
plot(ys', 'b');
plot(m, 'r');
mse_test = mse(ys - m);
rmse = sqrt(mse_test);
xlabel('Time (d)');
ylabel('Wind Speed (mph)');
legend('Confidence Interval','Y','Y Pred',2)