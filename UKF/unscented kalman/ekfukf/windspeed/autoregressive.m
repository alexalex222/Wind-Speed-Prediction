
% This is the code for predict the wind speed time series by autoregressive
%clear;
%clc;
% Import data
importfile('Blandford2009.dat');
% Choose proper wind speed data from all data set
speed=data(1:700,11);
speed=speed';
% use autoregressive
train=speed(1,1:500);
model= ar(train,9);
model.a;
[m,n]=size(model.a);
coef=zeros(m,n-1);
for i=2:n
    coef(m,i-1)=-model.a(m,i);
end

forpredict=speed(1,501:700);

% convert AR model to state space
[F,H,Q,R,initx,initV]=AR_to_SS(coef,model.NoiseVariance,forpredict);
F;
H;
Q;
R;
initx;
initV;