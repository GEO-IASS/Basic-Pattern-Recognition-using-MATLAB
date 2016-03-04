%Assigning the student number digits to the variables
s1 = 1;
s2 = 5;
s3 = 5;
s4 = 8;
s5 = 5;
s6 = 8;
s7 = 9;
%Getting the datasets for each class
d1 = (2 + (s1 + s2)/2)*randn(1,5 + s3 + s4 + s5);
d2 = 4 + (1 + (s1 + s2)/5)*randn(1,10 + s6 + s4 + s5);
d3 = 8 + (2 + (s1 + s2)/5)*randn(1,20 + s6 + s7 + s5);
%Initialising the new sample
newsample = [-2, 0, 2, 4, 6, 8, 10];%data points
newsample(2,:) = zeros(1, length(newsample));%To assign the classes later
d = [d1 d2 d3 newsample(1,:)];%Storing all data and new samples to a single vector
d(2,:) = [ones(1,length(d1)) ones(1, length(d2))+ones(1, length(d2)) ones(1, length(d3))+ones(1, length(d3))+ones(1, length(d3)) zeros(1, length(newsample))];%Used to store the class for each data point
%Sorting the data vector
[B, I] = sort(d,2);%B is the sorted array and I is the corresponding index
%Used to find the class of each sorted element in the data vector
class = zeros(1, length(I));
for i = 1:length(I)
    class(1, i) = d(2, I(1, i));
end
%Setting the value of k = 1 or 3, Change acccrodingly
k = 3;
%storing the sorted array and their respective class into a 2xn array. 
%1st row is the data points, 2nd row is their respective class.
dsort(1,:) = B(1,:);
dsort(2,:) = class(1,:);
temp = zeros(2, k);%Used to store the nearest data points(if 2 or 3, depends on value of k)
%For loop to find each new sample and the nearest k data points.
%Nearest data points is calculated using absolute difference.
%Classification for each new sample is done based on the maximum number
%of datapoints under a class in the neihghbour data points. 
for i = 1:length(dsort)
    dist1 = 0;
    dist2 = 0;
    j = 1;
    j1 = i + 1;%used to iterate to data points after the new sample
    j2 = i - 1;%used to iterate to data points before the new sample
    if(dsort(2, i) == 0)
        while(j<=k)%while loop to store k data points into temp vector
            while(dsort(2, j1) == 0)
                j1 = j1 + 1;%iterate if neighbour is a unclassified sample (data points after new sample)
            end
            while(dsort(2, j2) == 0)
                j2 = j2 -1;%iterate if neighbour is a unclassified sample (data points before new sample)
            end
            dist1 = abs(dsort(1, i) - dsort(1, j1));%calculating the absolute difference of neighbour and new sample (neighbour right of the data point)
            dist2 = abs(dsort(1, i) - dsort(1, j2));%calculating the absolute difference of neighbour and new sample (neighbour left of the data point)
            if(dist1<dist2)%if else statement to compare which data point is closer (between left and right data point)
                temp(:, j) = dsort(:, j1)
                j1 = j1 + 1;
                j = j + 1;
            elseif(dist2<dist1)
                temp(:, j) = dsort(:, j2);
                j2 = j2 - 1;
                j = j + 1;
            else
                temp(:, j) = dsort(:, j2);
                if(k>1)
                    temp(:, j+1) = dsort(:, j1);
                end
                j = j + 2;
                j1 = j1 + 1;
                j2 = j2 - 1;            
            end
        end
        %Classification
        %finding which class, in the k neighbouring points, has the highest
        %number of data points
        n = zeros(1, 3);
        for j = 1:size(temp, 2)
            if(temp(2, j) == 1)
                n(1, 1) = n(1, 1) + 1;
            elseif(temp(2, j) == 2)
                n(1, 2) = n(1, 2) + 1;
            else
                n(1, 3) = n(1, 3) + 1;
            end
        end
        pclassx = [n(1,1)/k n(1,2)/k n(1,3)/k]
        j = 1;
        flag = 0;
        %classifying the new sample to the highest number among the classes
        while((j<=length(pclassx)) & (flag == 0))
            if(pclassx(1, j) == max(pclassx))
                dsort(1, i)
                [r1, c1] = ismember(dsort(1, i), newsample(1,:));
                newsample(2,c1) = j;
                dsort(2, i) = j;
                flag = 1;
            end
            j = j + 1;
        end
    end
end

    
    
        
    
