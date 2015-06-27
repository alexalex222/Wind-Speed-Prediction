clear;
clc;
load Savoy;
data=Savoy;
% Choose proper wind speed data from all data set
speed=data(2000:2800,1);
speed=speed';
trainx=zeros(494,6);
trainy=zeros(494,1);
train=speed(1,1:500);
for i=1:494
    trainy(i)=speed(6+i+4);
    for j=1:6
        trainx(i,j)=speed(i+j-1);
    end
end
[b,~,r]=regress(trainy,trainx);
coef=fliplr(b');
r=var(r);
forpredict=speed(1,501:700);


for k=1:200
    arpredictvalue(1,k)=coef*fliplr(speed(1,500-6+k-4:499+k-4))';
end
MAPE=sum(abs((forpredict-arpredictvalue)./forpredict))/200;
MSE=sum((forpredict-arpredictvalue).^2)/200;

plot(forpredict,'-bs','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',3);figure(gcf)
hold on;
plot(arpredictvalue,'--*r');figure(gcf)
xlabel('time(10min)');
ylabel('wind speed(m/s)');
title('wind speed prediction by ANN(Blandford2009)');

legend('actual','predict');
hold off;
% convert AR model to state space
[F,H,Q,R,initx,initV]=AR_to_SS(coef,r,forpredict);
F;
H;
Q;
R;
initx;
initV;
