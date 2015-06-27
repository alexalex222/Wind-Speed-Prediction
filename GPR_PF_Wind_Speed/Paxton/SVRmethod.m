clear;
clc;
close all;

load paxton;
paxton=paxton+5;
x1=paxton(1:800);
x2=paxton(2:801);
x3=paxton(3:802);
x4=paxton(4:803);
x5=paxton(5:804);
x6=paxton(6:805);
x7=paxton(7:806);
x8=paxton(8:807);


past1=[x7, x6, x5, x4, x3];
past3=[x5, x4, x3, x2, x1];

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
Yhat1SVR=predict_Y1{1,2};
[R21SVR,RMSE1SVR]=rsquare(Ytest,Yhat1SVR);
MAPE1 = mean(abs(Yhat1SVR-Ytest)./Ytest);

figure
plot(Ytest,'LineWidth',3);
hold on
plot(Yhat1SVR,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');

[predict_Y3,~,~] = SVR(Ytrain,Xtrain3,Ytest,Xtest3,Method_option);
Yhat3SVR=predict_Y3{1,2};
[R23SVR,RMSE3SVR]=rsquare(Ytest,Yhat3SVR);
MAPE3 = mean(abs(Yhat3SVR-Ytest)./Ytest);

figure
plot(Ytest,'LineWidth',3);
hold on
plot(Yhat3SVR,'--r','LineWidth',3);
legend('Actual Y','Predicted Y')
xlabel('Sample');
ylabel('Y');