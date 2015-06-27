clear;
clc;
close all;
load('AllResults.mat');
Residuals1=Yhat1ARIMAVinalhaven-YtestVinalhaven;
Residuals2=Yhat1ANNVinalhaven-YtestVinalhaven;
Residuals3=Yhat1SVRVinalhaven-YtestVinalhaven;
Residuals4=Yhat1GPRVinalhaven-YtestVinalhaven;
Residuals5=Yhat1GPRPFVinalhaven-YtestVinalhaven;
Residuals6=Yhat3ARIMAVinalhaven-YtestVinalhaven;
Residuals7=Yhat3ANNVinalhaven-YtestVinalhaven;
Residuals8=Yhat3SVRVinalhaven-YtestVinalhaven;
Residuals9=Yhat3GPRVinalhaven-YtestVinalhaven;
Residuals10=Yhat3GPRPFVinalhaven-YtestVinalhaven;
subplot(5,2,1);

histfit(Residuals1,20);
ylabel('Count');
xlabel('Prediction Residuals (ARIMA)');
title('One-step-ahead Prediction Residuals');xlim([-4,4]);
box off;
subplot(5,2,3);
histfit(Residuals2,20);
ylabel('Count');
xlabel('Prediction Residuals (ANN)');
xlim([-4,4]);

box off;
subplot(5,2,5);

histfit(Residuals3,20);
ylabel('Count');
xlabel('Prediction Residuals (SVR)');
xlim([-4,4]);
box off;
subplot(5,2,7);
histfit(Residuals4,20);
ylabel('Count');
xlabel('Prediction Residuals (GPR)');
xlim([-4,4]);

box off;
subplot(5,2,9);

histfit(Residuals5,20);
ylabel('Count');
xlabel('Prediction Residuals (GPR-PF)');
xlim([-4,4]);
box off;
subplot(5,2,2);

histfit(Residuals6,20);
ylabel('Count');
xlabel('Prediction Residuals (ARIMA)');
title('Three-step-ahead Prediction Residuals');
xlim([-4,4]);
box off;
subplot(5,2,4);
histfit(Residuals7,20);
ylabel('Count');
xlabel('Prediction Residuals (ANN)');
xlim([-4,4]);
box off;
subplot(5,2,6);

histfit(Residuals8,20);
ylabel('Count');
xlabel('Prediction Residuals (SVR)');
xlim([-4,4]);
box off;
subplot(5,2,8);

histfit(Residuals9,20);
ylabel('Count');
xlabel('Prediction Residuals (GPR)');
xlim([-4,4]);
box off;
subplot(5,2,10);

histfit(Residuals10,20);
ylabel('Count');
xlabel('Prediction Residuals (GPR-PF)');
xlim([-4,4]);
box off;