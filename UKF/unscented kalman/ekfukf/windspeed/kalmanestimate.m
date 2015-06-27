% Use Kalman filter to estimate the wind speed based on AR model
clear;
clc;
autoregressive;

y=forpredict;
MM = zeros(size(M,1),200);
PP = zeros(size(M,1),size(M,1),200);
for i=1;200;
    [M,P,D] = ukf_predict1(M,P,f,Q,f_param,alpha,beta,kappa,mat);
    [M,P,K,MU,S,LH] = ukf_update1(M,P,Y,h,R,h_param,alpha,beta,kappa,mat);
    MM(:,k)   = M;
    PP(:,:,k) = P;
    

comparsion=[state;forpredict];
actualspeed=forpredict;
predictspeed=state(1,:);
MAPE=sum(abs((actualspeed-predictspeed)./actualspeed))/200;
RMSE=sqrt(sum((actualspeed-predictspeed).^2)/200);
plot(actualspeed,'-bs','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',3);figure(gcf)
hold on;
plot(predictspeed,'--*r');figure(gcf)
xlabel('samples(10min)');
ylabel('wind speed(m/s)');
title('wind speed prediction by AR-Kalamn filter(Blandford2009)');
axis([0,200,0,15]);
legend('actualspeed','predictspeed');
hold off;
