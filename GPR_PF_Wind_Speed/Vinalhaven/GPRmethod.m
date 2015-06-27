clear;
clc;
close all;

load vinalhaven;
% vinalhaven=smooth(vinalhaven,2,'sgolay',0);
vinalhaven=vinalhaven+5;
x1=vinalhaven(2001:2800);
x2=vinalhaven(2002:2801);
x3=vinalhaven(2003:2802);
x4=vinalhaven(2004:2803);
x5=vinalhaven(2005:2804);
x6=vinalhaven(2006:2805);
x7=vinalhaven(2007:2806);
x8=vinalhaven(2008:2807);

past1=[x7, x6, x5];
past3=[x5, x4, x3];

future=x8;

Xtrain1=past1(1:500,:);
Xtrain3=past3(1:500,:);
Ytrain=future(1:500);

Xtest1=past1(501:800,:);
Xtest3=past3(501:800,:);
YtestVinalhaven=future(501:800);

hyp.cov=[0;0];
hyp.mean = [0;0;0;0];
covfunc = @covSEiso; 
likfunc = @likGauss; 
hyp.lik = log(0.1);
meanfunc = {@meanSum, {@meanLinear, @meanConst}};

hyp1 = minimize(hyp, @gp, -1000, @infExact, meanfunc, covfunc, likfunc, Xtrain1(:,:), Ytrain);
% hyp1.mean=[0.8652; 0.075; 0.0023; 0.6933];
% hyp1.cov=[5.9353; -7.7508];
% hyp1.lik=-0.6954;

[Yhat1GPRVinalhaven, s1] = gp(hyp1, @infExact, meanfunc, covfunc, likfunc, Xtrain1, Ytrain, Xtest1);

hyp3 = minimize(hyp, @gp, -1000, @infExact, meanfunc, covfunc, likfunc, Xtrain3(:,:), Ytrain);
% hyp3.mean=[0.8004;0.157;-0.0531;1.1273];
% hyp3.cov=[5.9353; -7.7508];
% hyp3.lik=-0.2207;


[Yhat3GPRVinalhaven, s3] = gp(hyp3, @infExact, meanfunc, covfunc, likfunc, Xtrain3, Ytrain, Xtest3);
%%
[R21,RMSE1] = rsquare(YtestVinalhaven,Yhat1GPRVinalhaven);
MAPE1 = mean(abs(Yhat1GPRVinalhaven-YtestVinalhaven)./YtestVinalhaven);

[R23,RMSE3] = rsquare(YtestVinalhaven,Yhat3GPRVinalhaven);
MAPE3 = mean(abs(Yhat3GPRVinalhaven-YtestVinalhaven)./YtestVinalhaven);

figure
plot(YtestVinalhaven,'LineWidth',3);
hold on
plot(Yhat1GPRVinalhaven,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');

figure
plot(YtestVinalhaven,'LineWidth',3);
hold on
plot(Yhat3GPRVinalhaven,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');
