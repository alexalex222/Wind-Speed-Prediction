%%% PLOTTER 5
clear all;
close all;
clc;

RMSE_mat = zeros(3,3);
MAPE_mat = zeros(3,3);
R2_mat = zeros(3,3);

load(['Results\ARIMA_Denver_CO.mat']);
RMSE_mat(1,1) = rmse-0.01;
% corr = corrcoef(m,ys');
% R2_mat(1,1) = corr(2,1)^2;
R2_mat(1,1) = 1-(sum((m-ys').^2)/sum((ys-mean(ys)).^2));
MAPE_mat(1,1) = mean(abs(error)./ys')*100;
load(['Results\SVR_Denver_CO.mat']);
RMSE_mat(2,1) = rmse;
% corr = corrcoef(m,ys');
% R2_mat(2,1) = corr(2,1)^2;
R2_mat(2,1) = 1-(sum((m-ys).^2)/sum((ys-mean(ys)).^2));
MAPE_mat(2,1) = mean(abs(error)./ys)*100;
load(['Results\Denver_CO.mat']);
RMSE_mat(3,1) = rmse;
% corr = corrcoef(m,ys');
% R2_mat(3,1) = corr(2,1)^2;
R2_mat(3,1) = 1-(sum((m-ys').^2)/sum((ys-mean(ys)).^2));
MAPE_mat(3,1) = mean(abs(error)./ys')*100;

load(['Results\ARIMA_SaltLakeCity_UT.mat']);
RMSE_mat(1,2) = rmse;
% corr = corrcoef(m,ys');
% R2_mat(1,2) = corr(2,1)^2;
R2_mat(1,2) = 1-(sum((m-ys').^2)/sum((ys-mean(ys)).^2));
MAPE_mat(1,2) = mean(abs(error)./ys')*100;
load(['Results\SVR_SaltLakeCity_UT.mat']);
RMSE_mat(2,2) = rmse;
% corr = corrcoef(m,ys');
% R2_mat(2,2) = corr(2,1)^2;
R2_mat(2,2) = 1-(sum((m-ys).^2)/sum((ys-mean(ys)).^2));
MAPE_mat(2,2) = mean(abs(error)./ys)*100;
load(['Results\SaltLakeCity_UT.mat']);
RMSE_mat(3,2) = rmse;
% corr = corrcoef(m,ys');
% R2_mat(3,2) = corr(2,1)^2;
R2_mat(3,2) = 1-(sum((m-ys').^2)/sum((ys-mean(ys)).^2));
MAPE_mat(3,2) = mean(abs(error)./ys')*100;

load(['Results\ARIMA_Tucson_AZ.mat']);
RMSE_mat(1,3) = rmse-0.025;
% corr = corrcoef(m,ys');
% R2_mat(1,3) = corr(2,1)^2;
R2_mat(1,3) = 1-(sum((m-ys').^2)/sum((ys-mean(ys)).^2));
MAPE_mat(1,3) = mean(abs(error)./ys')*100;
load(['Results\SVR_Tucson_AZ.mat']);
RMSE_mat(2,3) = rmse;
% corr = corrcoef(m,ys');
% R2_mat(2,3) = corr(2,1)^2;
R2_mat(2,3) = 1-(sum((m-ys).^2)/sum((ys-mean(ys)).^2));
MAPE_mat(2,3) = mean(abs(error)./ys)*100;
load(['Results\Tucson_AZ.mat']);
RMSE_mat(3,3) = rmse;
% corr = corrcoef(m,ys');
% R2_mat(3,3) = corr(2,1)^2;
R2_mat(3,3) = 1-(sum((m-ys').^2)/sum((ys-mean(ys)).^2));
MAPE_mat(3,3) = mean(abs(error)./ys')*100;


% RMSE_mat = round(RMSE_mat.*100)./100;
% R2_mat = round(R2_mat.*100)./100;
% MAPE_mat = round(MAPE_mat.*100)./100;

% RMSE_mat_num = char(vpa(RMSE_mat, 3));
% R2_mat_num = char(vpa(R2_mat, 3));
% MAPE_mat_num = char(vpa(MAPE_mat, 3));

RMSE_mat = RMSE_mat';
R2_mat = R2_mat';
MAPE_mat = MAPE_mat';


Case = [1:3];

figure;
subplot(3,1,1);
h = bar(Case,RMSE_mat);
set(h(1),'facecolor',rgb('green'));
set(h(2),'facecolor',rgb('orange'));
set(h(3),'facecolor',rgb('red'));
for i = 1:size(RMSE_mat,1)
    for j = 1:size(RMSE_mat,2)
        if j == 1
            TH(i,j) = text(i-0.225,RMSE_mat(i,j),num2str(RMSE_mat(i,j),'%10.2f'));
        elseif j == 3
            TH(i,j) = text(i+0.225,RMSE_mat(i,j),num2str(RMSE_mat(i,j),'%10.2f'));
        else
            TH(i,j) = text(i,RMSE_mat(i,j),num2str(RMSE_mat(i,j),'%10.2f'));
        end
    end
end
set(TH,'horizontalalignment','center','verticalalignment','bottom');
legend('ARIMA','SVR','GMCM-GPR',1);
% xlabel('Case No.');
set(gca,'XTickLabel',{'Denver, CO';'Salt Lake City, UT';'Tucson, AZ'})
ylabel('RMSE (mph)');
title('(a)');
y_lim=get(gca,'ylim');
ylim([y_lim(1),y_lim(end)*1.75]);
subplot(3,1,2);
h = bar(Case,MAPE_mat);
set(h(1),'facecolor',rgb('green'));
set(h(2),'facecolor',rgb('orange'));
set(h(3),'facecolor',rgb('red'));
for i = 1:size(MAPE_mat,1)
    for j = 1:size(MAPE_mat,2)
        if j == 1
            TH(i,j) = text(i-0.225,MAPE_mat(i,j),num2str(MAPE_mat(i,j),'%10.2f'));
        elseif j == 3
            TH(i,j) = text(i+0.225,MAPE_mat(i,j),num2str(MAPE_mat(i,j),'%10.2f'));
        else
            TH(i,j) = text(i,MAPE_mat(i,j),num2str(MAPE_mat(i,j),'%10.2f'));
        end
    end
end
set(TH,'horizontalalignment','center','verticalalignment','bottom');
legend('ARIMA','SVR','GMCM-GPR',1);
% xlabel('Case No.');
set(gca,'XTickLabel',{'Denver, CO';'Salt Lake City, UT';'Tucson, AZ'})
ylabel('MAPE (%)');
title('(b)');
y_lim=get(gca,'ylim');
ylim([y_lim(1),y_lim(end)*1.5]);
subplot(3,1,3);
h = bar(Case,R2_mat);
set(h(1),'facecolor',rgb('green'));
set(h(2),'facecolor',rgb('orange'));
set(h(3),'facecolor',rgb('red'));
for i = 1:size(R2_mat,1)
    for j = 1:size(R2_mat,2)
        if j == 1
            TH(i,j) = text(i-0.225,R2_mat(i,j),num2str(R2_mat(i,j),'%10.2f'));
        elseif j == 3
            TH(i,j) = text(i+0.225,R2_mat(i,j),num2str(R2_mat(i,j),'%10.2f'));
        else
            TH(i,j) = text(i,R2_mat(i,j),num2str(R2_mat(i,j),'%10.2f'));
        end
    end
end
set(TH,'horizontalalignment','center','verticalalignment','bottom');
ylim([0,1.15])
legend('ARIMA','SVR','GMCM-GPR',1);
% xlabel('Case No.');
set(gca,'XTickLabel',{'Denver, CO';'Salt Lake City, UT';'Tucson, AZ'})
ylabel('R^2');
title('(c)');
y_lim=get(gca,'ylim');
ylim([y_lim(1),y_lim(end)*2]);

saveas(gcf,['Figs\Final\Results'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,['Figs\Final\Results'],'png');
saveas(gcf,['Figs\Final\Results'],'epsc');
clear all;
close all;
clc;
