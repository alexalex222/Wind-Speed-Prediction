clear;
clc;
close all;

load paxton;
x1=paxton(1:800);
x2=paxton(2:801);
x3=paxton(3:802);
x4=paxton(4:803);
x5=paxton(5:804);
x6=paxton(6:805);
x7=paxton(7:806);
x8=paxton(8:807);

[cor5,lags5]=crosscorr(x1,x6);
cor5=cor5(lags5==0);
[cor4,lags4]=crosscorr(x2,x6);
cor4=cor4(lags4==0);
[cor3,lags3]=crosscorr(x3,x6);
cor3=cor3(lags3==0);
[cor2,lags2]=crosscorr(x4,x6);
cor2=cor2(lags2==0);
[cor1,lags1]=crosscorr(x5,x6);
cor1=cor1(lags1==0);
[cor6,lags6]=crosscorr(x1,x7);
cor6=cor6(lags6==0);
[cor7,lags7]=crosscorr(x1,x8);
cor7=cor7(lags7==0);

cor=[cor1,cor2,cor3,cor4,cor5,cor6,cor7];
figure;
bar(cor);
xlabel('Lag');
ylabel('Cross-Correlation');
hold on;
% line([0 8],[0.8 0.8],'color','r','linestyle','--','LineWidth',2);
hold off;

