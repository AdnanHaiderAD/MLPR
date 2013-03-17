function [Y, W]=  linearRegression(x,y)
%perform univariate linear regression x<-denote the input data,y<- the target variable
 
N=length(x);% number of training examples
Y= ones(N,9);
count=1;
W=cell(9,1);% stores the weights found for each model
for k=1:2:17, %iterates over each model
   
    feature_matrix= zeros (N,k);
    
    for j=1:k
        
         if mod(j,2)==1
             feature_matrix(:,j) = 1/(j) * cos(2*pi*(j)*x);
         else
               feature_matrix(:,j) = 1/(j) * sin(2*pi*(j)*x);  
         end
    end
    feature_matrix= [feature_matrix ones(N,1)];
    [U,S,V] = svd(feature_matrix'*feature_matrix);
    inverse= U*(S\V');
    weights = inverse*feature_matrix'*y; % computes the weights for the current model
    y_predicted = feature_matrix*weights;
    Y(:,count)=y_predicted;
    W{count} = weights;
    count=count+1;
   
 
 
end
        
for i =1:9
    subplot(2,5,i)
    
    plot(x,y,'r+',x,Y(:,i),'b+')
    %axis([0 1 y_min y_max]);
    hold off
end


    
        
        
     
    
    