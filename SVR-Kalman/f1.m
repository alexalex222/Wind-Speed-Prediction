% Dynamical model function for the random sine signal demo

% Copyright (C) 2007 Jouni Hartikainen
%
% This software is distributed under the GNU General Public 
% Licence (version 2 or later); please refer to the file 
% Licence.txt, included with the software, for details.

function x_n = f1(x)
    load('regressionmodel.mat');
    model1=model;
    [a,~,~]=svmpredict(x,x,model1);
    x_n=a;
    end
    