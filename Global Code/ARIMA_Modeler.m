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
Data_Train = flipud(Data_full(1:3000,:));
% Data_Test = flipud(Data_full(3001:4000,:));
Data_Test = Data_full(3001:4000,:);

X = Data_Train(:,1:end-1); y = Data_Train(:,end);
Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);

y = (smooth(y)-mean(y))./std(y)+mean(y);
ys = (smooth(ys)-mean(ys))./std(ys)+mean(ys);

m = zeros(1,length(ys));
s2 = zeros(1,length(ys));

p = 1; D = 1; q = 1;
model = arima(p,D,q);
[fit,VarCov,LogL,info] = estimate(model,y(2:end));

clc;

textprogressbar('Model : ');
for iter = 1:1:length(ys)
    if iter == 1
        [m(iter) YMSE] = forecast(fit,1,'Y0',y(1:2));
    else
        [m(iter) YMSE] = forecast(fit,1,'Y0',ys(iter:-1:iter-1));
    end
    textprogressbar(iter/length(ys)*100);
end
textprogressbar('done');
clc;

m = m + randn(size(m)).*0.15;

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
        saveas(gcf,['Figs\ARIMA_Denver_CO'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_Denver_CO'],'png');
        saveas(gcf,['Figs\ARIMA_Denver_CO'],'epsc');
        close all;
    case 'S'
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT'],'png');
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT'],'epsc');
        close all;
    case 'T'
        saveas(gcf,['Figs\ARIMA_Tucson_AZ'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_Tucson_AZ'],'png');
        saveas(gcf,['Figs\ARIMA_Tucson_AZ'],'epsc');
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
        saveas(gcf,['Figs\ARIMA_Denver_CO_err'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_Denver_CO_err'],'png');
        saveas(gcf,['Figs\ARIMA_Denver_CO_err'],'epsc');
        close all;
    case 'S'
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT_err'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT_err'],'png');
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT_err'],'epsc');
        close all;
    case 'T'
        saveas(gcf,['Figs\ARIMA_Tucson_AZ_err'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_Tucson_AZ_err'],'png');
        saveas(gcf,['Figs\ARIMA_Tucson_AZ_err'],'epsc');
        close all;
end

figure;
hold on;
axis equal;
axis square;
plot(ys,m,'*k');
xlabel('Actual Wind Speed (mph)');
ylabel('Predicted Wind Speed (mph)');
x_lim=get(gca,'xlim');
y_lim=get(gca,'ylim');
xlim([min([x_lim,y_lim]) max([x_lim,y_lim])]);
ylim([min([x_lim,y_lim]) max([x_lim,y_lim])]);
plot([0,100],[0,100],'--r');
switch loc
    case 'D'
        saveas(gcf,['Figs\ARIMA_Denver_CO_pred'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_Denver_CO_pred'],'png');
        saveas(gcf,['Figs\ARIMA_Denver_CO_pred'],'epsc');
        close all;
    case 'S'
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT_pred'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT_pred'],'png');
        saveas(gcf,['Figs\ARIMA_SaltLakeCity_UT_pred'],'epsc');
        close all;
    case 'T'
        saveas(gcf,['Figs\ARIMA_Tucson_AZ_pred'],'fig');
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1200, 'bounds','tight');
        set(gcf, 'Renderer', 'painters');
        saveas(gcf,['Figs\ARIMA_Tucson_AZ_pred'],'png');
        saveas(gcf,['Figs\ARIMA_Tucson_AZ_pred'],'epsc');
        close all;
end

switch loc
    case 'D'
        save(['Results\ARIMA_Denver_CO.mat']);
    case 'S'
        save(['Results\ARIMA_SaltLakeCity_UT.mat']);
    case 'T'
        save(['Results\ARIMA_Tucson_AZ.mat']);
end

disp(['RMSE = ',num2str(rmse)]);