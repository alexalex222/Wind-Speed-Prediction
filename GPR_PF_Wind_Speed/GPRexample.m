clear;
close all;
clc;

% generate some data from a Gaussian process
meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0.5; 1];
covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
n = 20;
x = gpml_randn(0.3, n, 1);
K = feval(covfunc{:}, hyp.cov, x);
mu = feval(meanfunc{:}, hyp.mean, x);
y = chol(K)'*gpml_randn(0.15, n, 1) + mu + exp(hyp.lik)*gpml_randn(0.2, n, 1);

plot(x, y, '+');
 

nlml = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y);

z = linspace(-1.9, 1.9, 101)';
[m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z);

  f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)]; 
  fill([z; flipdim(z,1)], f, [7 7 7]/8);
  hold on; 
  plot(z, m); 
  plot(x, y, '+');
  
  covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);

  hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, x, y);
  exp(hyp2.lik)
  nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, x, y)

  [m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, z);
  f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
  fill([z; flipdim(z,1)], f, [7 7 7]/8);
  hold on; 
  plot(z, m); 
  plot(x, y, '+');
  
  
  hyp.cov = [0; 0]; hyp.mean = [0; 0]; hyp.lik = log(0.1);
  hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);
  [m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z);
 
  f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
  fill([z; flipdim(z,1)], f, [7 7 7]/8)
  hold on; plot(z, m); plot(x, y, '+');
  
  nu = fix(n/2); u = linspace(-1.3,1.3,nu)';
  covfuncF = {@covFITC, {covfunc}, u};
  [mF s2F] = gp(hyp, @infFITC, meanfunc, covfuncF, likfunc, x, y, z);
  
  nu = fix(n/2); iu = randperm(n); iu = iu(1:nu); u = x(iu,:);
  