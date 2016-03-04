%Student Number Assignment
s1 = 1;
s2 = 5;
s3 = 5;
s4 = 8;
s5 = 5;
s6 = 8;
s7 = 9;
%Creating the datasets for each class
d1 = (2 + (s1 + s2)/2)*randn(1,5 + s3 + s4 + s5);
d2 = 4 + (1 + (s1 + s2)/5)*randn(1,10 + s6 + s4 + s5);
d3 = 8 + (2 + (s1 + s2)/5)*randn(1,20 + s6 + s7 + s5);
%Creating the range of values for the estimation
range = [-4 : 0.01 : 12];
%Finding the Likelihood for the range under each class
p1 = ksdensity(d1, range);
p2 = ksdensity(d2, range);
p3 = ksdensity(d3, range);
%Plotting the Likelihood
figure(1), plot(range, p1, 'r-', range, p2, 'b-', range, p3, 'g-');
ylabel('p(x|classj)', 'fontsize', 10);
xlabel('datasets', 'fontsize', 10);
%Calculating the Prior Probability for each of the classes
P1 = length(d1)/(length(d1)+length(d2) + length(d3));
P2 = length(d2)/(length(d1)+length(d2) + length(d3));
P3 = length(d3)/(length(d1)+length(d2) + length(d3));
%Calculating the Evidence
%Evidence = sum_I=0_to_N(LikelihoodI * PriorI); N - number of classes
px = (p1*P1) + (p2*P2) + (p3*P3);
%Calculating the Posterior probability of the range w.r.t each class
%Posterior = (Likelihood*Prior)/Evidence
pclass1 = (p1*P1)./px;
pclass2 = (p2*P2)./px;
pclass3 = (p3*P3)./px;
%Plotting the Posterior Probability for range r w.r.t each class
figure(2), plot(range, pclass1, 'r-', range, pclass2, 'b-', range, pclass3, 'g-');
xlabel('x', 'fontsize', 10);
ylabel('p(classj|x)', 'fontsize', 10);
%Assigning the new sample
newsample = [-2, 0, 2, 4, 6, 8, 10];
%Finding the Likelihood for the new sample under each class
p1new = ksdensity(d1, newsample);
p2new = ksdensity(d2, newsample);
p3new = ksdensity(d3, newsample);
%Calculating the Evidence for the new samples
%Evidence = sum_I=0_to_N(LikelihoodI * PriorI); N - number of classes
pxnew = (p1new*P1) + (p2new*P2) + (p3new*P3);
%Calculating the Posterior Probability of the new sample w.r.t each class
%Posterior = (Likelihood*Prior)/Evidence
pclass1new = (p1new*P1)./pxnew;
pclass2new = (p2new*P2)./pxnew;
pclass3new = (p3new*P3)./pxnew;
%Classification based on the highest probability
sampleclass = zeros(1, length(newsample));
for i = 1:length(newsample)
    if(pclass1(1, i)>=pclass2(1, i) & pclass1(1, i)>=pclass3(1, i))
        sampleclass(1, i) = 1;
    elseif(pclass2(1, i)>=pclass3(1, i))
        sampleclass(1, i) = 2;
    else
        sampleclass(1, i) = 3;
    end
end

