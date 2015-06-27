%%% PLOTTER 4
clear all;
close all;
clc;

load('denver_co.mat');
Data_full = Data;
Data_Train = flipud(Data_full(1:3000,:));
Data_Test = Data_full(3001:4000,:);
X = Data_Train(:,1:end-1); y = Data_Train(:,end);
Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);
figure;
hold on;
index = 1:1:length(y);
for i_iter = min(nonzeros(X(:,3))):1:max(X(:,3))
for j_iter = [1,4,7,10,2,5,8,11,3,6,9,12];
    if any(j_iter==1:3)
        plot(index(X(:,3)==i_iter&X(:,2)==j_iter),y(X(:,3)==i_iter&X(:,2)==j_iter),'-','Color',rgb('green'));
    elseif any(j_iter==4:6)
        plot(index(X(:,3)==i_iter&X(:,2)==j_iter),y(X(:,3)==i_iter&X(:,2)==j_iter),'--','Color',rgb('orange'));
    elseif any(j_iter==7:9)
        plot(index(X(:,3)==i_iter&X(:,2)==j_iter),y(X(:,3)==i_iter&X(:,2)==j_iter),':','Color',rgb('blue'));
    elseif any(j_iter==10:12)
        plot(index(X(:,3)==i_iter&X(:,2)==j_iter),y(X(:,3)==i_iter&X(:,2)==j_iter),'-.','Color',rgb('red'));
    end
end
end
xlabel('Sample');
ylabel('Wind Speed (mph)');
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4',1);
axis tight;
% xlim([0,13]);
saveas(gcf,['Figs\Final\Cluster'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,['Figs\Final\Cluster'],'png');
saveas(gcf,['Figs\Final\Cluster'],'epsc');
clear all;
close all;
clc;

% load('saltlakecity_ut.mat');
% Data_full = Data;
% Data_Train = flipud(Data_full(1:3000,:));
% Data_Test = Data_full(3001:4000,:);
% X = Data_Train(:,1:end-1); y = Data_Train(:,end);
% Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);
% figure;
% hold on;
% for iter = [1,4,7,10,2,5,8,11,3,6,9,12];
%     if any(iter==1:3)
%         plot(X(X(:,2)==iter,2),y(X(:,2)==iter),'*r');
%     elseif any(iter==4:6)
%         plot(X(X(:,2)==iter,2),y(X(:,2)==iter),'*k');
%     elseif any(iter==7:9)
%         plot(X(X(:,2)==iter,2),y(X(:,2)==iter),'*g');
%     elseif any(iter==10:12)
%         plot(X(X(:,2)==iter,2),y(X(:,2)==iter),'*b');
%     end
% end
% xlabel('Month');
% ylabel('Wind Speed (mph)');
% legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4',1);
% axis tight;
% xlim([0,13]);
% saveas(gcf,['Figs\Final\SaltLakeCity_UT_cluster'],'fig');
% maximize;
% applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
% set(gcf, 'Renderer', 'painters');
% saveas(gcf,['Figs\Final\SaltLakeCity_UT_cluster'],'png');
% saveas(gcf,['Figs\Final\SaltLakeCity_UT_cluster'],'epsc');
% clear all;
% close all;
% clc;
% 
% load('tucson_az.mat');
% Data_full = Data;
% Data_Train = flipud(Data_full(1:3000,:));
% Data_Test = Data_full(3001:4000,:);
% X = Data_Train(:,1:end-1); y = Data_Train(:,end);
% Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);
% figure;
% hold on;
% for iter = [1,4,7,10,2,5,8,11,3,6,9,12];
%     if any(iter==1:3)
%         plot(X(X(:,2)==iter,2),y(X(:,2)==iter),'*r');
%     elseif any(iter==4:6)
%         plot(X(X(:,2)==iter,2),y(X(:,2)==iter),'*k');
%     elseif any(iter==7:9)
%         plot(X(X(:,2)==iter,2),y(X(:,2)==iter),'*g');
%     elseif any(iter==10:12)
%         plot(X(X(:,2)==iter,2),y(X(:,2)==iter),'*b');
%     end
% end
% xlabel('Month');
% ylabel('Wind Speed (mph)');
% legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4',1);
% axis tight;
% xlim([0,13]);
% saveas(gcf,['Figs\Final\Tucson_AZ_cluster'],'fig');
% maximize;
% applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
% set(gcf, 'Renderer', 'painters');
% saveas(gcf,['Figs\Final\Tucson_AZ_cluster'],'png');
% saveas(gcf,['Figs\Final\Tucson_AZ_cluster'],'epsc');
% clear all;
% close all;
% clc;

