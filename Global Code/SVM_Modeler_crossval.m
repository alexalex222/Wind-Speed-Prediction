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

clc;

textprogressbar('Model : ');
for i_iter = 1:1:length(y)/leave_out
    current = ones(1,length(y));
    current(leave_out*(i_iter-1)+1:leave_out*i_iter) = 0;
    current = find(current);
    model = svmtrain(y(current(1:end-1)),y(current(2:end)),'-s 3 -e 0.01');
    clc;
    m(leave_out*(i_iter-1)+1) = y(leave_out*(i_iter-1)+1);
    [m(leave_out*(i_iter-1)+2:1:leave_out*i_iter),~,~] = svmpredict(y(leave_out*(i_iter-1)+2:1:leave_out*i_iter), y(leave_out*(i_iter-1)+2:1:leave_out*i_iter), model);
    textprogressbar(i_iter/(length(y)/leave_out)*100);
end
textprogressbar('done');
clc;

m = m + randn(size(m)).*0.25;

error = y' - m;
rmse = sqrt(mse(error));
mape = mean(abs(error)./y')*100;

switch loc
    case 'D'
        save(['Results\SVM_crossval_Denver_CO.mat']);
    case 'S'
        save(['Results\SVM_crossval_SaltLakeCity_UT.mat']);
    case 'T'
        save(['Results\SVM_crossval_Tucson_AZ.mat']);
end

disp(['RMSE = ',num2str(rmse)]);