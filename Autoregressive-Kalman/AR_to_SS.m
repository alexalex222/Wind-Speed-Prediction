function [F,H,Q,R,initx, initV] = AR_to_SS(coef, C, y)
%
% Convert a vector auto-regressive model of order k to state-space form.
% [F,H,Q,R] = AR_to_SS(coef, C, y)
% 
% X(i) = A(1) X(i-1) + ... + A(k) X(i-k+1) + v, where v ~ N(0, C)
% and A(i) = coef(:,:,i) is the weight matrix for i steps ago.
% We initialize the state vector with [y(:,k)' ... y(:,1)']', since
% the state vector stores [X(i) ... X(i-k+1)]' in order.

[s k] = size(coef); % s is the size of the state vector
%bs = s * ones(1,k); % size of each block

F = zeros(k,k);
for i=1:k
   F(1, i) = coef(1,i);
end
for i=1:k-1
  F(i+1, i) = 1;
end

H = zeros(s,k);
% we get to see the most recent component of the state vector 
H(1,1) = 1; 
%for i=1:k
%  H(block(1,bs), block(i,bs)) = eye(s);
%end

Q = C;

R = C+0.3;

initx = zeros(k*s, 1);
for i=1:k
  initx(i) = y(1,k-i+1); % concatenate the first k observation vectors
end

initV = 1; % no uncertainty about the state (since perfectly observable)
