clc;
clear;
close all;

load PaxtonAll;
load VinalhavenAll;

subplot 211
plot(PaxtonAll,'LineWidth',2);
hold on;
line([500,500],[8,18],'color','r','linestyle','--');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
title('(a)');
hold off;

subplot 212
plot(VinalhavenAll,'LineWidth',2);
hold on;
line([500,500],[8,18],'color','r','linestyle','--');
xlabel('Sample');
ylabel('Wind Speed (m/s)');
title('(b)');
hold off;