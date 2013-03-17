function Y= Bayesregression(x,y)
N=length(x);% number of training examples
Y= ones(N,11);
count=1;
feature_matrix= zeros (N,7);
  %extraction of features  
 for j=1:7
      if mod(j,2)==1
            feature_matrix(:,j) = 1/(j) * cos(2*pi*(j)*x);
      else
             feature_matrix(:,j) = 1/(j) * sin(2*pi*(j)*x);  
       end
 end
 feature_matrix= [feature_matrix ones(N,1)];
 %maximum posterior weights
 for i=0:10,
    [U,S,V] = svd(feature_matrix'*feature_matrix+i*eye(8));
    inverse= U*(S\V');
    weights=inverse*feature_matrix'*y;
    y_predicted = feature_matrix*weights;
    Y(:,count)=y_predicted;
    count=count+1;
 end
  
 for i =1:11
    subplot(3,4,i)
    
    plot(x,y,'r+',x,Y(:,i),'b+')
    %axis([0 1 y_min y_max]);
    hold off
 end
end
 
 