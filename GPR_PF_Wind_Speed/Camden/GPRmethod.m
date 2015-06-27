clear;
clc;
close all;

load camden;
camden=smooth(camden,3);
camden=camden+5;
x1=camden(9001:9800);
x2=camden(9002:9801);
x3=camden(9003:9802);
x4=camden(9004:9803);
x5=camden(9005:9804);
x6=camden(9006:9805);
x7=camden(9007:9806);
x8=camden(9008:9807);

past1=[x7, x6, x5];
past3=[x5, x4, x3];

future=x8;

Xtrain1=past1(1:500,:);
Xtrain3=past3(1:500,:);
Ytrain=future(1:500);

Xtest1=past1(501:800,:);
Xtest3=past3(501:800,:);
Ytest=future(501:800);

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

[Yhat1GPR, s1] = gp(hyp1, @infExact, meanfunc, covfunc, likfunc, Xtrain1, Ytrain, Xtest1);

hyp3 = minimize(hyp, @gp, -1000, @infExact, meanfunc, covfunc, likfunc, Xtrain3(:,:), Ytrain);
% hyp3.mean=[0.8004;0.157;-0.0531;1.1273];
% hyp3.cov=[5.9353; -7.7508];
% hyp3.lik=-0.2207;


[Yhat3GPR, s3] = gp(hyp3, @infExact, meanfunc, covfunc, likfunc, Xtrain3, Ytrain, Xtest3);
%%
[R21,RMSE1] = rsquare(Ytest,Yhat1GPR);
MAPE1 = mean(abs(Yhat1GPR-Ytest)./Ytest);

[R23,RMSE3] = rsquare(Ytest,Yhat3GPR);
MAPE3 = mean(abs(Yhat3GPR-Ytest)./Ytest);

figure
plot(Ytest,'LineWidth',3);
hold on
plot(Yhat1GPR,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');

figure
plot(Ytest,'LineWidth',3);
hold on
plot(Yhat3GPR,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');
