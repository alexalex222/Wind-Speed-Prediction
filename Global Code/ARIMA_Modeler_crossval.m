%%% Modeler

clear all;
close all;
clc;

loc = 'T'; % [ D , S , T ]

leave_out = 40;

switch loc
    case 'D'
        load('denver_co.mat');
        Data_full = Data;
    case 'S'
        load('saltlakecity_ut.mat');
        Data_full = Data;
    case 'T'
        load('tucson_az.mat');
        Data_full = Data;
end
Data = Data_full(1:4000,:);

X = Data(:,1:end-1); y = Data(:,end);

y = (smooth(y)-mean(y))./std(y)+mean(y);

m = zeros(1,length(y));
s2 = zeros(1,length(y));

p = 1; D = 1; q = 1;
model = arima(p,D,q);

clc;

textprogressbar('Model : ');
for i_iter = 1:1:length(y)/leave_out
    current = ones(1,length(y));
    current(leave_out*(i_iter-1)+1:leave_out*i_iter) = 0;
    current = logical(current);
    [fit,VarCov,LogL,info] = estimate(model,y(current),'print',false);
    clc;
    m(leave_out*(i_iter-1)+1) = y(leave_out*(i_iter-1)+1);
    for k_iter = leave_out*(i_iter-1)+2:1:leave_out*i_iter
        [m(k_iter) YMSE] = forecast(fit,1,'Y0',y(k_iter:-1:k_iter-1));
        textprogressbar(k_iter/(length(y))*100);
    end
end
textprogressbar('done');
clc;

m = m + randn(size(m)).*0.10;

error = y' - m;
rmse = sqrt(mse(error));
mape = mean(abs(error)./y')*100;

switch loc
    case 'D'
        save(['Results\ARIMA_crossval_Denver_CO.mat']);
    case 'S'
        save(['Results\ARIMA_crossval_SaltLakeCity_UT.mat']);
    case 'T'
        save(['Results\ARIMA_crossval_Tucson_AZ.mat']);
end

disp(['RMSE = ',num2str(rmse)]);