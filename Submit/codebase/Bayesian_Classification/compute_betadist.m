function[expert1_Var,expert2_Var,expert1_M,expert2_M, expert1_EM,expert2_EM]  = compute_betadist(X,a1,b1,a2,b2)
% X provides 100 possible simulations where X(n,k) is the nth case that
% arrives in the kth situation, a1=10,b1=10, a2=100,b2=20 <- these are the
% parameter values for the two prior beta distributions , .
[r, c] = size(X);

%variance of the posterior distribution where expert1_Var(n,k) represents
%the variance of the expert 1's posterior after seeing the nth observation
%at the kth iteration.
expert1_Var= ones(r,c);
expert2_Var= ones(r,c);

%posterior mean where expert1_M(n,k) represents
%the mean of the expert 1's posterior after seeing the nth observation
%at the kth iteration.
expert1_M= ones(r,c);
expert2_M=ones(r,c);
for i=1:c,
    x= X(:,i);
    count=0;
    for j=1:length(x),
        if x(j)==1
               count=count+1;
        end       
        expert1_M(j,i)=(count+a1)/(j+a1+b1);
        expert2_M(j,i)=(count+a2)/(j+a2+b2);
        expert1_Var(j,i)=((count+a1)*(j-count+b1))/((a1+j+b1)^2*(a1+j+b1+1));
        expert2_Var(j,i)= ((count+a2)*(j-count+b2))/((a2+j+b2)^2*(a2+j+b2+1));
end
%empirical mean where expert1_EM(n,k) represents
%the empirical mean of the expert 1's posterior after seeing the nth observation

expert1_EM =ones(r,1);
expert2_EM= ones(r,1);
for i=1:r
    expert1_EM(i) = mean(expert1_M(i,:));
    expert2_EM(i) =mean(expert2_M(i,:));
end
end
    
       
        
    