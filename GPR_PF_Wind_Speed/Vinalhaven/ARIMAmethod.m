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

Yhat1ARIMA=Xtest1*b1+normrnd(0,0.5,[300,1]);
Yhat3ARIMA=Xtest3*b3+normrnd(0,0.77,[300,1]);

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