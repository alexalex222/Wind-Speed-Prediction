clear;
clc;

% importfile('falmouth2004.dat');
load Savoy;
data=Savoy;
% Choose proper wind speed data from all data set
speed=data(2000:2800,1);
speed=speed';
% use autoregressive
train=speed(1,1:500);
forpredict=speed(1,501:700);
    
model= ar(train,6);
[m,n]=size(model.a);
coef=zeros(m,n-1);
for p=2:n
    coef(m,p-1)=-model.a(m,p);
end
arpredictvalue=zeros(1,200);
for k=1:200
    arpredictvalue(1,k)=coef*fliplr(speed(1,500-6+k:499+k))';
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
% save ARFalmouth1step.mat

% convert AR model to state space
[F,H,Q,R,initx,initV]=AR_to_SS(coef,model.NoiseVariance,forpredict);
F;
H;
Q;
R;
initx;
initV;
