% Use Kalman filter to estimate the wind speed based on AR model
clear;
clc;
ARalone;
%B=[0 0 0 0 0 0 0 0 0]';
%statespace =ss(F,B,H,0,-1);
%arpredictvalue=zeros(1,200);
%{
for k=1:200
    arpredictvalue(1,k)=coef*fliplr(speed(1,494+k:494+k+5))';
end
%}


y=forpredict;
[state, V, VV, loglik] = kalman_filter(y, F, H, Q, R, initx, initV);

comparsion=[state;forpredict];
actualspeed=forpredict;
predictspeed=state(1,:);
MAPE=sum(abs((actualspeed-predictspeed)./actualspeed))/200;
MSE=sum((actualspeed-predictspeed).^2)/200;


plot(actualspeed,'-bs','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',3);figure(gcf)
hold on;
plot(predictspeed,'--*r');figure(gcf)
plot(arpredictvalue,'o'); figure(gcf)
xlabel('samples(10min)');
ylabel('wind speed(m/s)');
title('wind speed prediction by AR-Kalamn filter(Blandford2009)');

legend('ActualSpeed','AR-KalmanPredictSpeed','ARpredictvalue');
hold off;

save ARKalmanFalmouth2step
