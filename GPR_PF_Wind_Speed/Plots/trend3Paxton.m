%This file is to generate the plot of trend, error distribution and
%correlation between YtestPaxton speed and predict speed of Blandford by 5
%different methods
clear;
close all;
load('AllResults.mat');
x=1:300;
subplot(5,1,1)
plot(YtestPaxton);                     
hold on
plot( x(1:3:300),Yhat3ARIMAPaxton(1:3:300), 'dg');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
% title('Three-step-ahead Wind Speed Prediction in Paxton');
legend('Actual Speed','Predicted Speed (ARIMA)','Location','SouthWest');
hold off
subplot(5,1,2);
plot(YtestPaxton); 
hold on
plot( x(1:3:300),Yhat3ANNPaxton(1:3:300),'pc');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (ANN)','Location','SouthWest');
hold off

subplot(5,1,3);
plot(YtestPaxton); 
hold on
plot( x(1:3:300),Yhat3SVRPaxton(1:3:300),'o','Color',[1 0.5 0.2]);
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (SVR)','Location','SouthWest');
hold off

subplot(5,1,4);

plot(YtestPaxton); 
hold on
plot( x(1:3:300),Yhat3GPRPaxton(1:3:300),'+k');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (GPR)','Location','SouthWest');
hold off

subplot(5,1,5);

plot(YtestPaxton); 
hold on
plot( x(1:3:300),Yhat3GPRPFPaxton(1:3:300),'*r');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (GPR-PF)','Location','SouthWest');
hold off