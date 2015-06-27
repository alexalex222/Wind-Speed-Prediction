clear;
clc;
importfile('Blandford2009.dat');% import wind speed data
speed=data(1:700,11);
speed=speed';
forpredict=speed(1,501:700);
n=9;      %number of state
q=0.1;    %std of process 
r=0.1;    %std of measurement
Q=q^2*eye(n); % covariance of process
R=r^2;        % covariance of measurement  
f=@(x)[0.802*x(1)+0.1445*x(2)+0.0348*x(3)-0.0502*x(4)+0.0574*x(5)-0.0118*x(6)-0.0786*x(7)+0.078*x(8)+0.0196*x(9);x(1);x(2);x(3);x(4);x(5);x(6);x(7);x(8)];  % nonlinear state equations
h=@(x)x(1);                               % measurement equation
s=[7.2;5.7;6;6.2;5.6;5.7;5.7;5.4;6.1];                                % initial state
x=s+q*randn(9,1); %initial state          % initial state with noise
P = eye(n);                               % initial state covraiance
N=200;                                     % total dynamic steps
xV = zeros(n,N);          %estmate        % allocate memory
sV = zeros(n,N);          %actual
zV = zeros(1,N);
for k=1:N
  z = forpredict(k) ;                     % measurments
  sV(:,k)= s;                             % save actual state
  zV(k)  = z;                             % save measurment
  [x, P] = ukf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
  s = f(s) + q*randn(9,1);                % update process 
end


  plot( forpredict, '-');
  hold on
  plot( xV(1,:), '--*r');
  hold off

