clear all;close all;
P=1:10;
T=[2.523 2.434 3.356 4.115 5.834 6.967 7.098 8.315 9.387 9.928];
net=newrbe(P,T,2);
y=sim(net,P);
figure;
plot(P,y-T,':+');
title('Îó²îÇúÏß');