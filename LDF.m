%Student Number Assignment
s1 = 1;
s2 = 5;
s3 = 5;
s4 = 8;
s5 = 5;
s6 = 8;
s7 = 9;
%Assigning X value
X = [0 2; 1, 2; 2, 1; -3, 1; -2, -1; -3, -2;];
%Assigning Y value: adding a column vector of full 1's, i.e adding 1 to
%each row in X
for i = 1:length(X)
    Y(i, :) = [1, X(i,:)];
end
%Initialising a and b basedon the student number
b = [1 + s1, 1 + s2, 1 + s3, 1 + s4,  1 + s4, 1 + s6];
a = [1 + s1, 1 + s2, 1 + s3];
%Assigning the learning rate to 0.1
n = 0.1;
%k is used to iterate through Y and b
k = 1;
%predic is used to calculate the prediction at each iteration, i.e
%predic(k,1) = a_new*Y_k
predic = zeros(12, 1);
%a_new is used to store the new a value at each iteration
anew = zeros(12, length(a));
%diff is used to calculate the difference between output and prediction
diff = zeros(12, 1);
%for loop to iterate from 1 to 12
%Used to update a based on the difference (diff) and learning rate
for i = 1:12
    predic(i,1) = Y(k,:)*transpose(a);
    diff(i, 1) = b(1,k) - (Y(k,:)*transpose(a));    
    anew(i,:) = a+(n*diff(i, 1)*Y(k,:));%Updating a and storing in a_new
    a = anew(i, :); %used to store previous iteration a value
    k = k + 1;  
    if(k>6)
        k = 1;%If reached last element in Y, go back to the first element
    end
end
