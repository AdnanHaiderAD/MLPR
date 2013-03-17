function E= log_evidence(x,y)
% compute ln(p(D|model)) where model is distinguished by the parameter k
E= zeros(1,9);
count=1;
[N,c]=size(x);
for k=1:2:17, %creates the feature matrix for each model
   
    feature_matrix= zeros (N,k);
    
    for j=1:k
        
         if mod(j,2)==1
             feature_matrix(:,j) = 1/(j) * cos(2*pi*(j)*x);
         else
               feature_matrix(:,j) = 1/(j) * sin(2*pi*(j)*x);  
         end
    end
    feature_matrix= [feature_matrix ones(N,1)];
    
    for i=1:N
     
       
    E(count)= E(count) + bayesregress(feature_matrix(i,:),y(i)); % compute the log of the evidence of model i
    end
    count=count+1;
end
end
