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
plot( x(1:3:300),Yhat1ARIMAPaxton(1:3:300), 'dg');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
% title('One-step-ahead Wind Speed Prediction in Paxton');
legend('Actual Speed','Predicted Speed (ARIMA)','Location','SouthEast');
hold off
subplot(5,1,2);
plot(YtestPaxton); 
hold on
plot( x(1:3:300),Yhat1ANNPaxton(1:3:300),'pc');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (ANN)','Location','SouthEast');
hold off

subplot(5,1,3);
plot(YtestPaxton); 
hold on
plot( x(1:3:300),Yhat1SVRPaxton(1:3:300),'o','Color',[1 0.5 0.2]);
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (SVR)','Location','SouthEast');
hold off

subplot(5,1,4);

plot(YtestPaxton); 
hold on
plot( x(1:3:300),Yhat1GPRPaxton(1:3:300),'+k');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (GPR)','Location','SouthEast');
hold off

subplot(5,1,5);

plot(YtestPaxton); 
hold on
plot( x(1:3:300),Yhat1GPRPFPaxton(1:3:300),'*r');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
legend('Actual Speed','Predicted Speed (GPR-PF)','Location','SouthEast');
hold off