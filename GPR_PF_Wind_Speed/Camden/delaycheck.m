clear;
clc;
close all;

load camden;
x1=camden(6001:6800);
x2=camden(6002:6801);
x3=camden(6003:6802);
x4=camden(6004:6803);
x5=camden(6005:6804);
x6=camden(6006:6805);
x7=camden(6007:6806);

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

cor=[cor1,cor2,cor3,cor4,cor5,cor6];
figure;
bar(cor);
xlabel('Lag');
ylabel('Cross-Correlation');
hold on;
line([0 7],[0.8 0.8],'color','r','linestyle','--','LineWidth',2);
hold off;

