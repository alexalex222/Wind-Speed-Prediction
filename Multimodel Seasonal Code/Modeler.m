%%% Modeler

clear all;
close all;
clc;

loc = 'T'; % [ D , S , T ]

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

cluster_idx = zeros(size(Data,1),1);
years = unique(Data_full(:,3));
months = unique(Data_full(:,2));
k_iter = 1;
for i_iter = 1:1:numel(years)
    for j_iter = 1:1:numel(months)
        cluster_idx((Data_full(:,3)==years(i_iter))&(Data_full(:,2)==months(j_iter))) = k_iter;
        if any(j_iter==[3,6,9,12])
            k_iter = k_iter+1;
        end
    end
end

num_years_train = 10;
num_years_test = 3;

train_idx = find(ismember(Data_full(:,3),years(1):years(num_years_train)));
test_idx = find(ismember(Data_full(:,3),years(num_years_train)+1:years(num_years_train+num_years_test)));
Data_Train = flipud(Data_full(train_idx,:));
Data_Test = flipud(Data_full(test_idx,:));
% cluster_idx = flipud(cluster_idx);

X = Data_Train(:,1:end-1); y = Data_Train(:,end);
Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);

cluster_idx_train = cluster_idx(train_idx);
cluster_idx_test = cluster_idx(test_idx);

y = (smooth(y)-mean(y))./std(y)+mean(y);
ys = (smooth(ys)-mean(ys))./std(ys)+mean(ys);

for iter = 1:1:numel(unique(cluster_idx_train))
    gmm_model(iter) = gmmb_fj(y(cluster_idx_train==iter), 'Cmax', 1, 'thr', 1e-9);
    % gmm_model(iter).sigma = permute(gmm_model.sigma,[1 3 2]);
end

for i_iter = 1:1:length(y)
    for j_iter = 1:1:length(gmm_model)
        posterior(j_iter,i_iter) = gmm_model(j_iter).weight*normcdf(y(i_iter),gmm_model(j_iter).mu,gmm_model(j_iter).sigma)/...
            sum([gmm_model(1:end).weight].*cdf('Normal',y(i_iter),[gmm_model(1:end).mu],[gmm_model(1:end).sigma]));
    end
end

[max_posterior,max_idx] = max(posterior);

for i_iter = 1:1:length(ys)
    for j_iter = 1:1:length(gmm_model)
        posterior_test(j_iter,i_iter) = gmm_model(j_iter).weight*normcdf(ys(i_iter),gmm_model(j_iter).mu,gmm_model(j_iter).sigma)/...
            sum([gmm_model(1:end).weight].*cdf('Normal',ys(i_iter),[gmm_model(1:end).mu],[gmm_model(1:end).sigma]));
    end
end

[max_posterior_test,max_test_idx] = max(posterior_test);

m = zeros(1,length(ys));
s2 = zeros(1,length(ys));

clc;

% textprogressbar('Train Model : ');
for iter = 1:1:length(gmm_model)
    % hyp(iter) = []; hyp2(iter) = [];
    covfunc{iter} = @covSEiso;
    likfunc{iter} = @likGauss;
    sn(iter) = 0.1;
    hyp.lik(iter) = log(sn(iter));
    hyp2(iter).cov = [0;0];
    hyp2(iter).lik = log(0.1);
    y_train = y(cluster_idx_train==iter);
    hyp2(iter) = minimize(hyp2(iter), @gp, -100, @infExact, [], covfunc{iter}, likfunc{iter}, y_train(3:end), y_train(2:end-1));
    exp(hyp2(iter).lik);
    nlml2(iter) = gp(hyp2(iter), @infExact, [], covfunc{iter}, likfunc{iter}, y_train(2:end), y_train(1:end-1));
    % textprogressbar(iter/length(y)*100);
end
% textprogressbar('done');

clc;

textprogressbar('Test  Model : ');
for iter = 1:1:length(ys)
    if iter == 1
        model_idx = max_idx(1);
        y_data = y(cluster_idx_train==model_idx);
        [m(iter),s2(iter)] = gp(hyp2(model_idx), @infExact, [], covfunc(model_idx), likfunc(model_idx), y_data(3:end), y_data(2:end-1), y(1));
    else
        model_idx = max_test_idx(iter);
        y_data = y(cluster_idx_train==model_idx);
        % y = [ys(iter-1);y];
        [m(iter),s2(iter)] = gp(hyp2(model_idx), @infExact, [], covfunc(model_idx), likfunc(model_idx), y_data(2:end), y_data(1:end-1), ys(iter));
    end
    textprogressbar(iter/length(ys)*100);
end
textprogressbar('done');
clc;

error = ys' - m;

figure;
hold on;
% f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
% x = [1:length(m)];
% fill([x; flipdim(x,1)], f, [7 7 7]/8);
plot(ys, '-b');
plot(m, 'xr');
rmse = sqrt(mse(error));
xlabel('Time (d)');
ylabel('Wind Speed (mph)');
% legend('Confidence Interval','Actual','Predicted',1);
legend('Actual','Predicted',1);
axis tight;
switch loc
    case 'D'
        saveas(gcf,['Figs\Denver_CO'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\Denver_CO'],'png');
        saveas(gcf,['Figs\Denver_CO'],'epsc');
        close all;
    case 'S'
        saveas(gcf,['Figs\SaltLakeCity_UT'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\SaltLakeCity_UT'],'png');
        saveas(gcf,['Figs\SaltLakeCity_UT'],'epsc');
        close all;
    case 'T'
        saveas(gcf,['Figs\Tucson_AZ'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\Tucson_AZ'],'png');
        saveas(gcf,['Figs\Tucson_AZ'],'epsc');
        close all;
end

% ploterrhist(error,'bins',30);
figure;
hold on;
histfit(error);
xlabel('Error');
ylabel('Instances');
axis tight;
switch loc
    case 'D'
        saveas(gcf,['Figs\Denver_CO_err'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\Denver_CO_err'],'png');
        saveas(gcf,['Figs\Denver_CO_err'],'epsc');
        close all;
    case 'S'
        saveas(gcf,['Figs\SaltLakeCity_UT_err'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\SaltLakeCity_UT_err'],'png');
        saveas(gcf,['Figs\SaltLakeCity_UT_err'],'epsc');
        close all;
    case 'T'
        saveas(gcf,['Figs\Tucson_AZ_err'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\Tucson_AZ_err'],'png');
        saveas(gcf,['Figs\Tucson_AZ_err'],'epsc');
        close all;
end

figure;
hold on;
axis equal;
axis square;
plot(m,ys,'*k');
xlabel('Predicted Wind Speed (mph)');
ylabel('Actual Wind Speed (mph)');
x_lim=get(gca,'xlim');
y_lim=get(gca,'ylim');
xlim([min([x_lim,y_lim]) max([x_lim,y_lim])]);
ylim([min([x_lim,y_lim]) max([x_lim,y_lim])]);
plot([0,100],[0,100],'--r');
switch loc
    case 'D'
        saveas(gcf,['Figs\Denver_CO_pred'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\Denver_CO_pred'],'png');
        saveas(gcf,['Figs\Denver_CO_pred'],'epsc');
        close all;
    case 'S'
        saveas(gcf,['Figs\SaltLakeCity_UT_pred'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\SaltLakeCity_UT_pred'],'png');
        saveas(gcf,['Figs\SaltLakeCity_UT_pred'],'epsc');
        close all;
    case 'T'
        saveas(gcf,['Figs\Tucson_AZ_pred'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\Tucson_AZ_pred'],'png');
        saveas(gcf,['Figs\Tucson_AZ_pred'],'epsc');
        close all;
end

switch loc
    case 'D'
        save(['Results\Denver_CO.mat']);
    case 'S'
        save(['Results\SaltLakeCity_UT.mat']);
    case 'T'
        save(['Results\Tucson_AZ.mat']);
end
