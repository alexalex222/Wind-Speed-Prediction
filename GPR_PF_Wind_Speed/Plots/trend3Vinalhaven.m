%This file is to generate the plot of trend, error distribution and
%correlation between YtestVinalhaven speed and predict speed of Blandford by 5
%different methods
clear;
close all;
load('AllResults.mat');
x=1:300;
subplot(5,1,1)
plot(YtestVinalhaven);                     
hold on
plot( x(1:3:300),Yhat3ARIMAVinalhaven(1:3:300), 'dg');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
% title('Three-step-ahead Wind Speed Prediction in Vinalhaven');
legend('Actual Speed','Predicted Speed (ARIMA)','Location','South');
hold off
subplot(5,1,2);
plot(YtestVinalhaven); 
hold on
plot( x(1:3:300),Yhat3ANNVinalhaven(1:3:300),'pc');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (ANN)','Location','South');
hold off

subplot(5,1,3);
plot(YtestVinalhaven); 
hold on
plot( x(1:3:300),Yhat3SVRVinalhaven(1:3:300),'o','Color',[1 0.5 0.2]);
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (SVR)','Location','South');
hold off

subplot(5,1,4);

plot(YtestVinalhaven); 
hold on
plot( x(1:3:300),Yhat3GPRVinalhaven(1:3:300),'+k');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (GPR)','Location','South');
hold off

subplot(5,1,5);

plot(YtestVinalhaven); 
hold on
plot( x(1:3:300),Yhat3GPRPFVinalhaven(1:3:300),'*r');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (GPR-PF)','Location','South');
hold off