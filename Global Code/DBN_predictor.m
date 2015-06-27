%%% Modeler

clear all;
close all;
clc;

% load('denver_co.mat');
% Data_full = Data;
load('saltlakecity_ut.mat');
Data_full = Data;
% load('tucson_az.mat');
% Data_full = Data;
Data_Train = Data_full(1:3000,:);
Data_Test = Data_full(4001:5000,:);

X = Data_Train(1:10,1:end-1); y = Data_Train(1:10,end);
Xs = Data_Test(1:10,1:end-1); ys = Data_Test(1:10,end);

intra = zeros(1);
intra(1,1) = 0;
inter = zeros(1);
inter(1,1) = 1;
n = 1;

Y = 1; % size of observable state

ns = [Y];
dnodes = [];
onodes = [1];
% bnet = mk_dbn(intra, inter, ns, 'discrete', dnodes);
bnet = mk_dbn(intra, inter, ns, 'discrete', dnodes, 'observed', onodes);
for i=1:2
  bnet.CPD{i} = gaussian_CPD(bnet, i);
end

% engine = jtree_dbn_inf_engine(bnet);
% engine = smoother_engine(jtree_dbn_inf_engine(bnet));
T = length(y); % fixed length sequences

engine = {};
%engine{end+1} = hmm_inf_engine(bnet);
engine{end+1} = jtree_unrolled_dbn_inf_engine(bnet, T);
%engine{end+1} = smoother_engine(hmm_2TBN_inf_engine(bnet));
%engine{end+1} = smoother_engine(jtree_2TBN_inf_engine(bnet));

training{1} = num2cell(y');

maxiter = 100;     %% The number of iterations of EM (max)
epsilon = 1e-100; %% A very small stopping criterion

[bnet2, ll, engine2] = learn_params_em(engine{1}, training, 'max_iter', maxiter);
