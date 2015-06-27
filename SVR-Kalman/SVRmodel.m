% This file is to build the SVR model for wind speed
clear;
clc;
%import data
load('Blandford2009.mat');% import wind speed data
speed=Blandford2009(1:700,11);
trainspeed=speed(1:500,1);
testspeed=speed(501:700,1);
forpredict=speed(501:700,1);
predictspeed = zeros(1,length(testspeed));
s2 = zeros(1,length(testspeed));
model = svmtrain(trainspeed(6:end),trainspeed(1:end-5),'-s 3');

[predictspeed,~,~] = svmpredict(testspeed, speed(501:700), model);

save regressionmodel.mat model

MAPE=sum(abs((testspeed-predictspeed)./testspeed))/200;
MSE=sum((testspeed-predictspeed).^2)/200;

plot( testspeed, '-bs','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',3);
  hold on
  plot( predictspeed, '--*r');
  xlabel('samples(10min)');
  ylabel('wind speed(m/s)');
  title('Wind Speed Prediction by SVR(Blandford2009)');
  legend('actualspeed','predictspeed');
  hold off
save svrpredict.mat predictspeed;
