%%% READER

clear all;
close all;
clc;

% data = xlsread('saltlakecity_ut.xlsx','B4:AA1250');
% data = xlsread('saltlakecity_ut.xlsx','B5:AA723');
data = xlsread('tucson_az.xlsx','B3:AA721');

k = 0;
for i = 1:1:size(data,1)
    for j = 1:1:size(data,2)
        if ~isnan(data(i,j)) && rem(j,2)==0
            k = k + 1;
            Data(k,:) = data(i,j-1:j);
        end
    end
end
init = find(Data(:,1)==1);
j = 0;
k = 1965;
for i = 1:1:length(init)-1
    j = j + 1;
    Month(init(i):init(i+1)-1) = repmat(j,1,length(init(i):init(i+1)-1));
    Year(init(i):init(i+1)-1) = repmat(k,1,length(init(i):init(i+1)-1));
    if j == 12
        j = 0;
        k = k + 1;
    end
end
Month(init(i):size(Data,1)) = repmat(j+1,1,length(init(i):size(Data,1)));
Year(init(i):size(Data,1)) = repmat(k,1,length(init(i):size(Data,1)));
Height = repmat(6.1,1,size(Data,1));

% Elevation = 1288;
% Elevation = mean(1564,1731);
Elevation = 728;

Data = [Data(:,1),Month',Year',Height',Data(:,2)];

% save('saltlakecity_ut.mat','Data');
% save('denver_co.mat','Data');
save('tucson_az.mat','Data');