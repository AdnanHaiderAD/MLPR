function compute_mean_squared_error( x,Y, y, test_x,test_y,W)
%Y <- the predicted Y values for each x in  the training data
%y<- the actual target values of the training data
%test_x< - the input x of the test data
%test_y<- the actual target values of the test data
% W<- weights found for each model during training

[r,c] =size(Y);
%computing the mean squared error for the training data
error = zeros(1,c);
for i= 1: c
    error(i) = sum((Y(:,i)-y).^2)/r;
end

%prediction of test data
r1 =length(test_x);
Y_pred =zeros(r1,c);
%create feature matrix
count=1;
for k=1:2:17, %iterates over each model to get their respective predictions on the test data
   
    feature_matrix= zeros (r1,k);
    
    for j=1:k
        
         if mod(j,2)==1
             feature_matrix(:,j) = 1/(j) * cos(2*pi*(j)*test_x);
         else
               feature_matrix(:,j) = 1/(j) * sin(2*pi*(j)*test_x);  
         end
    end
    feature_matrix= [feature_matrix ones(r1,1)];
    
    Y_pred(:,count)= feature_matrix*W{count};
    count=count+1;
end



% computing the mean squared error for the test data
error2= zeros (1,c);
for i= 1: c
    error2(i) = mean((Y_pred(:,i)-test_y).^2);
end
subplot (2,1,1)
plot ([1:2:17],(error),'b' )
subplot(2,1,2)
plot([1:2:17],(error2),'r');

  %for i =1:9
   % subplot(2,5,i)
    
   % plot(test_x,test_y,'r+',test_x,Y_pred(:,i),'b+')
    
   % plot(x,y,'r+',x,Y(:,i),'b+')
    
    %axis([0 1 y_min y_max]);
    hold off
end  