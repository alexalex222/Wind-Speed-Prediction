clear;
close all;
load('AllResults.mat');
x=6:20;
y=x;
subplot(2,2,1);
plot(YtestPaxton(1:3:300),Yhat1ARIMAPaxton(1:3:300),'dg');
hold on
plot(YtestPaxton(1:3:300),Yhat1ANNPaxton(1:3:300),'pc');
plot(YtestPaxton(1:3:300),Yhat1SVRPaxton(1:3:300),'o','Color',[1 0.5 0.2]);
plot(YtestPaxton(1:3:300),Yhat1GPRPaxton(1:3:300),'+k');
plot(YtestPaxton(1:3:300),Yhat1GPRPFPaxton(1:3:300),'*r');
plot(x,y,'--','LineWidth',1.5);
xlabel('Actual speed (m/s)');
ylabel('Predicted speed (m/s)');
title('(a) One-step-ahead Wind Speed Prediction in Paxton');
legend('ARIMA','ANN','SVR','GPR','GPR-PF');
hold off
subplot(2,2,2);
plot(YtestPaxton(1:3:300),Yhat3ARIMAPaxton(1:3:300),'dg');
hold on
plot(YtestPaxton(1:3:300),Yhat3ANNPaxton(1:3:300),'pc');
plot(YtestPaxton(1:3:300),Yhat3SVRPaxton(1:3:300),'o','Color',[1 0.5 0.2]);
plot(YtestPaxton(1:3:300),Yhat3GPRPaxton(1:3:300),'+k');
plot(YtestPaxton(1:3:300),Yhat3GPRPFPaxton(1:3:300),'*r');
plot(x,y,'--','LineWidth',1.5);
xlabel('Actual speed (m/s)');
ylabel('Predicted speed (m/s)');
title('(b) Three-step-ahead Wind Speed Prediction in Paxton');
hold off

subplot(2,2,3);
plot(YtestVinalhaven(1:3:300),Yhat1ARIMAVinalhaven(1:3:300),'dg');
hold on
plot(YtestVinalhaven(1:3:300),Yhat1ANNVinalhaven(1:3:300),'pc');
plot(YtestVinalhaven(1:3:300),Yhat1SVRVinalhaven(1:3:300),'o','Color',[1 0.5 0.2]);
plot(YtestVinalhaven(1:3:300),Yhat1GPRVinalhaven(1:3:300),'+k');
plot(YtestVinalhaven(1:3:300),Yhat1GPRPFVinalhaven(1:3:300),'*r');
plot(x,y,'--','LineWidth',1.5);
xlabel('Actual speed (m/s)');
ylabel('Predicted speed (m/s)');
title('(c) One-step-ahead Wind Speed Prediction in Vinalhaven');
% legend('ARIMA','ANN','SVR','GPR','GPR-PF','Location','NorthWest');
hold off
subplot(2,2,4);
plot(YtestVinalhaven(1:3:300),Yhat3ARIMAVinalhaven(1:3:300),'dg');
hold on
plot(YtestVinalhaven(1:3:300),Yhat3ANNVinalhaven(1:3:300),'pc');
plot(YtestVinalhaven(1:3:300),Yhat3SVRVinalhaven(1:3:300),'o','Color',[1 0.5 0.2]);
plot(YtestVinalhaven(1:3:300),Yhat3GPRVinalhaven(1:3:300),'+k');
plot(YtestVinalhaven(1:3:300),Yhat3GPRPFVinalhaven(1:3:300),'*r');
plot(x,y,'--','LineWidth',1.5);
xlabel('Actual speed (m/s)');
ylabel('Predicted speed (m/s)');
title('(d) Three-step-ahead Wind Speed Prediction in Vinalhaven');
hold off

