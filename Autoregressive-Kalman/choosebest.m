clear;
importfile('Falmouth2004.dat');

% Choose proper wind speed data from all data set
speed=data(51:800,1);
speed=speed';
% use autoregressive
train=speed(1,1:500);
forpredict=speed(1,501:700);
RMSE=zeros(1,11);
MAPE=zeros(1,11);
for i=2:12
    
model= ar(train,i);
[m,n]=size(model.a);
coef=zeros(m,n-1);
for p=2:n
    coef(m,p-1)=-model.a(m,p);
end
arpredictvalue=zeros(1,200);
for k=1:200
    
    
    arpredictvalue(1,k)=coef*fliplr(speed(1,500-i+k:499+k))';
end
MAPE(1,i)=sum(abs((forpredict-arpredictvalue)./forpredict))/200;
RMSE(1,i)=sqrt(sum((forpredict-arpredictvalue).^2)/200);
end
