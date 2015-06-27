%%% PLOTTER 4
clear all;
close all;
clc;

load('denver_co.mat');
Data_full = Data;
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
% num_years_train = 10;
% num_years_test = 3;
% train_idx = find(ismember(Data_full(:,3),years(1):years(num_years_train)));
% test_idx = find(ismember(Data_full(:,3),years(num_years_train)+1:years(num_years_train+num_years_test)));
% Data_Train = flipud(Data_full(train_idx,:));
% Data_Test = flipud(Data_full(test_idx,:));
% cluster_idx = flipud(cluster_idx);
Data_Train = flipud(Data_full(1:3000,:));
% Data_Test = flipud(Data_full(3001:4000,:));
Data_Test = Data_full(3001:4000,:);
X = Data_Train(:,1:end-1); y = Data_Train(:,end);
Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);
cluster_idx_train = cluster_idx(1:3000);
figure;
hold on;
j_iter = 1;
for i_iter = 1:1:numel(unique(cluster_idx_train));
    if j_iter==1
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'sr');
    elseif j_iter == 2
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'*k');
    elseif j_iter == 3
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'xg');
    elseif j_iter == 4
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'ob');
        j_iter = 1;
    end
    j_iter = j_iter+1;
end
xlabel('Month');
ylabel('Wind Speed (mph)');
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4',1);
axis tight;
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'png');
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'epsc');
clear all;
close all;
clc;

load('saltlakecity_ut.mat');
Data_full = Data;
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
% num_years_train = 10;
% num_years_test = 3;
% train_idx = find(ismember(Data_full(:,3),years(1):years(num_years_train)));
% test_idx = find(ismember(Data_full(:,3),years(num_years_train)+1:years(num_years_train+num_years_test)));
% Data_Train = flipud(Data_full(train_idx,:));
% Data_Test = flipud(Data_full(test_idx,:));
% cluster_idx = flipud(cluster_idx);
Data_Train = flipud(Data_full(1:3000,:));
% Data_Test = flipud(Data_full(3001:4000,:));
Data_Test = Data_full(3001:4000,:);
X = Data_Train(:,1:end-1); y = Data_Train(:,end);
Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);
cluster_idx_train = cluster_idx(1:3000);
figure;
hold on;
j_iter = 1;
for i_iter = 1:1:numel(unique(cluster_idx_train));
    if j_iter==1
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'sr');
    elseif j_iter == 2
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'*k');
    elseif j_iter == 3
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'xg');
    elseif j_iter == 4
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'ob');
        j_iter = 1;
    end
    j_iter = j_iter+1;
end
xlabel('Month');
ylabel('Wind Speed (mph)');
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4',1);
axis tight;
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'png');
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'epsc');
clear all;
close all;
clc;

load('tucson_az.mat');
Data_full = Data;
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
% num_years_train = 10;
% num_years_test = 3;
% train_idx = find(ismember(Data_full(:,3),years(1):years(num_years_train)));
% test_idx = find(ismember(Data_full(:,3),years(num_years_train)+1:years(num_years_train+num_years_test)));
% Data_Train = flipud(Data_full(train_idx,:));
% Data_Test = flipud(Data_full(test_idx,:));
% cluster_idx = flipud(cluster_idx);
Data_Train = flipud(Data_full(1:3000,:));
% Data_Test = flipud(Data_full(3001:4000,:));
Data_Test = Data_full(3001:4000,:);
X = Data_Train(:,1:end-1); y = Data_Train(:,end);
Xs = Data_Test(:,1:end-1); ys = Data_Test(:,end);
cluster_idx_train = cluster_idx(1:3000);
figure;
hold on;
j_iter = 1;
for i_iter = 1:1:numel(unique(cluster_idx_train));
    if j_iter==1
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'sr');
    elseif j_iter == 2
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'*k');
    elseif j_iter == 3
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'xg');
    elseif j_iter == 4
        plot(X(cluster_idx_train==i_iter,2),y(cluster_idx_train==i_iter),'ob');
        j_iter = 1;
    end
    j_iter = j_iter+1;
end
xlabel('Month');
ylabel('Wind Speed (mph)');
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4',1);
axis tight;
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'png');
saveas(gcf,['Figs\Final\Denver_CO_cluster'],'epsc');
clear all;
close all;
clc;

