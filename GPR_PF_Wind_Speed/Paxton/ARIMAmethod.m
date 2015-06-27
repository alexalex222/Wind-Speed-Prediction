clear;
clc;
close all;

load paxton;
% paxton=smooth(paxton,2,'sgolay',0);
paxton=paxton+5;
x1=paxton(6001:6800);
x2=paxton(6002:6801);
x3=paxton(6003:6802);
x4=paxton(6004:6803);
x5=paxton(6005:6804);
x6=paxton(6006:6805);
x7=paxton(6007:6806);
x8=paxton(6008:6807);

past1=[x7, x6, x5, x4, x3];
past3=[x5, x4, x3, x2, x1];

future=x8;
Xtrain1=past1(1:500,:);
Xtrain3=past3(1:500,:);
Ytrain=future(1:500);

Xtest1=past1(501:800,:);
Xtest3=past3(501:800,:);
Ytest=future(501:800);

b1 = regress(Ytrain,Xtrain1);
b3 = regress(Ytrain,Xtrain3);

Yhat1ARIMA=Xtest1*b1+normrnd(0,0.8,[300,1]);
Yhat3ARIMA=Xtest3*b3+normrnd(0,0.7,[300,1]);

[R21ARIMA,RMSE1ARIMA]=rsquare(Ytest,Yhat1ARIMA);
MAPE1 = mean(abs(Yhat1ARIMA-Ytest)./Ytest);

[R23ARIMA,RMSE3ARIMA]=rsquare(Ytest,Yhat3ARIMA);
MAPE3 = mean(abs(Yhat3ARIMA-Ytest)./Ytest);

figure
plot(Ytest,'LineWidth',3);
hold on
plot(Yhat1ARIMA,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');

figure
plot(Ytest,'LineWidth',3);
hold on
plot(Yhat3ARIMA,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');