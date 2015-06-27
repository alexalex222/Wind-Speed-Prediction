
clc;
load('Blandford2009.mat');% import wind speed data
speed=Blandford2009(1:700,11);
speed=speed';
forpredict=speed(1,501:700);

n=1;      %number of state
q=2.3;    %std of process 
r=0.9;    %std of measurement
Q=q^2*eye(n); % covariance of process
R=r^2;        % covariance of measurement  
f=@(x)[f1(x(1))];  % nonlinear state equations
h=@(x)x(1);                               % measurement equation
s=[7.2];                                % initial state
x=s+q*randn(n,1); %initial state          % initial state with noise
P = eye(n);                               % initial state covraiance
N=200;                                     % total dynamic steps
xV = zeros(n,N);          %estmate        % allocate memory
sV = zeros(n,N);          %actual
zV = zeros(1,N);
for k=1:N
  z = forpredict(k)+r*randn(1,1) ;                     % measurments
  sV(:,k)= s;                             % save actual state
  zV(k)  = z;                             % save measurment
  [x, P] = ukf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
  s = f(s) + q*randn(n,1);                % update process 
end

MAPE=sum(abs((forpredict-xV)./forpredict))/200;
MSE=sum((forpredict-xV).^2)/200;
R2=rsquare(forpredict,xV);
load('svrpredict.mat');
  plot( forpredict, '-bs','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',3);
  hold on
  plot( xV(1,:), '--*r');
  plot(predictspeed,'o');
  xlabel('samples(10min)');
  ylabel('wind speed(m/s)');
  title('Wind Speed Prediction by SVR-Unscented Kalman Filter(Blandford2009)');
  legend('ActualSpeed','SVR-UKFPredictSpeed','SVRPredictSpeed');
  hold off
save SVRUKF-Blandford5step
