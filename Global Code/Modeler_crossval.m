%%% Modeler

clear all;
close all;
clc;

loc = 'T'; % [ D , S , T ]

leave_out = 400;

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

clc;

textprogressbar('Model : ');
for i_iter = 1:1:length(y)/leave_out
    current = ones(1,length(y));
    current(leave_out*(i_iter-1)+1:leave_out*i_iter) = 0;
    current = find(current);
    hyp = []; hyp2 = [];
    covfunc = @covSEiso;
    likfunc = @likGauss;
    sn = 0.1;
    hyp.lik = log(sn);
    hyp2.cov = [0;0];
    hyp2.lik = log(0.1);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, y(current(2:end)), y(current(1:end-1)));
    exp(hyp2.lik);
    nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, y(2:end), y(1:end-1));
    clc;
    m(leave_out*(i_iter-1)+1) = y(leave_out*(i_iter-1)+1);
    for k_iter = leave_out*(i_iter-1)+2:1:leave_out*i_iter
        [m(k_iter),s2(k_iter)] = gp(hyp2, @infExact, [], covfunc, likfunc, y(current(2:end)), y(current(1:end-1)), y(k_iter));
        textprogressbar(k_iter/(length(y))*100);
    end
end
textprogressbar('done');
clc;

error = y' - m;
rmse = sqrt(mse(error));
mape = mean(abs(error)./y')*100;

switch loc
    case 'D'
        save(['Results\crossval_Denver_CO.mat']);
    case 'S'
        save(['Results\crossval_SaltLakeCity_UT.mat']);
    case 'T'
        save(['Results\crossval_Tucson_AZ.mat']);
end
