% Dynamical model function for the random sine signal demo

% Copyright (C) 2007 Jouni Hartikainen
%
% This software is distributed under the GNU General Public 
% Licence (version 2 or later); please refer to the file 
% Licence.txt, included with the software, for details.

function x_n = f1(x)
    x_n(1,1)=0.63*x(1,1)-0.45*x(2,1)+0.38*x(3,1);
    x_n(2,1)=x(1,1);
    x_n(3,1)=x(2,1);
    end
    