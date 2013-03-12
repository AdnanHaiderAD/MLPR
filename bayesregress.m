function [logevidence]=bayesregress(xdata,ydata,V,alpha,N0);
%function [logevidence]=bayesregress(ydata,xdata,V,alpha,N0);
%or
%function [logevidence]=bayesregress(ydata,xdata);
%
%  XDATA - Covariate data, with each column corresponding to a different
%  data point.
%
%  YDATA - Target data, with each column corresponding to a different data
%  point.
%
%  LOGEVIDENCE - the log of the evidence associated with a Bayesian Linear 
%  Regressor for those inputs.
%
%

% Copyright 2011 Amos Storkey, University of Edinburgh. Licensed under the
%WTFPL. Everyone is permitted to copy and distribute verbatim or modified 
%copies of this licensed document/code in whatever form, and changing it is 
%allowed as long as the name is changed or the change is clearly 
%differentiated by some other means. Obviously, this document/code comes 
%with no warranty about anything to the extent permitted by applicable law.

%Wishart prior S0,n
%

%Various dimenisons
N = size(xdata,2);
d = size(ydata,1);
m = size(xdata,1);
%Default set up
if nargin==2;
  V=eye(d);
  alpha=1;%/mean(diag(xdata*xdata'));
  N0=1;
end

%Define M and K and S0
M=zeros(d,m);
K=alpha* xdata*xdata';

S0=N0*eye(d);

%Compute required data
Sxx=xdata*xdata'+K;
Sxxinv=inv(Sxx);
%[U S V] =svd(Sxx);
%Sxxinv= U *inv(S)*V';
%Evidence is t distributed.
logevidence = logtdist(ydata,M*xdata,S0,eye(N)-xdata'*Sxxinv*xdata,N+N0);


function logprob = logtdist(Y,M,V,K,n);
%Compute the log matrix t density
d=size(Y,1);
m=size(K,1);
Vinv=inv(V);

logprob = sum(gammaln((n+1-[1:d])./2))-sum(gammaln((n-m+1-[1:d])./2))+d*sum(log(eig(K)))/2-m*sum(log(eig(pi*V)))./2-n/2*sum(log(eig((Y-M)'*Vinv*(Y-M)*K+eye(m))));