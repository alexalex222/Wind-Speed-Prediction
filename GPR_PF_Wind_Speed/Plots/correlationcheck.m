clear;
clc;
close all;

load corPaxton;
load corVinalhaven;

figure;
subplot 121
bar(corPaxton);
xlabel('Lag');
ylabel('Correlation');
title('(a)');
% hold on;
% line([0 8],[0.8 0.8],'color','r','linestyle','--','LineWidth',2);
% hold off;

subplot 122
bar(corVinalhaven);
xlabel('Lag');
ylabel('Correlation');
title('(b)');
% hold on;
% line([0 8],[0.8 0.8],'color','r','linestyle','--','LineWidth',2);
% hold off;
