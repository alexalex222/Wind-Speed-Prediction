clear;
clc;
close all;

load vinalhaven;
vinalhaven=vinalhaven+5;
x1=vinalhaven(2001:2800);
x2=vinalhaven(2002:2801);
x3=vinalhaven(2003:2802);
x4=vinalhaven(2004:2803);
x5=vinalhaven(2005:2804);
x6=vinalhaven(2006:2805);
x7=vinalhaven(2007:2806);
x8=vinalhaven(2008:2807);


past1=[x7, x6];
past3=[x5, x4, x3, x2];

future=x8;
Xtrain1=past1(1:500,:);
Xtrain3=past3(1:500,:);
Ytrain=future(1:500);

Xtest1=past1(501:800,:);
Xtest3=past3(501:800,:);
Ytest=future(501:800);

% model1 = svmtrain(Xtrain1,Ytrain,'-s 3');
% [Yhat1SVR,~,~] = svmpredict(Ytest, Xtest1, model1);
% 
% [R21SVR,RMSE1SVR]=rsquare(Ytest,Yhat1SVR);
% MAPE1 = mean(abs(Yhat1SVR-Ytest)./Ytest);
Method_option.plotOriginal = 0;
Method_option.xscale = 1;
Method_option.yscale = 1;
Method_option.plotScale = 0;
Method_option.pca = 0;
Method_option.type = 5;

[predict_Y1,~,~] = SVR(Ytrain,Xtrain1,Ytest,Xtest1,Method_option);
Yhat1SVRVinalhaven=predict_Y1{1,2};
[R21SVR,RMSE1SVR]=rsquare(Ytest,Yhat1SVRVinalhaven);
MAPE1 = mean(abs(Yhat1SVRVinalhaven-Ytest)./Ytest);

figure
plot(Ytest,'LineWidth',3);
hold on
plot(Yhat1SVRVinalhaven,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');

[predict_Y3,~,~] = SVR(Ytrain,Xtrain3,Ytest,Xtest3,Method_option);
Yhat3SVRVinalhaven=predict_Y3{1,2};
[R23SVR,RMSE3SVR]=rsquare(Ytest,Yhat3SVRVinalhaven);
MAPE3 = mean(abs(Yhat3SVRVinalhaven-Ytest)./Ytest);

figure
plot(Ytest,'LineWidth',3);
hold on
plot(Yhat3SVRVinalhaven,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');