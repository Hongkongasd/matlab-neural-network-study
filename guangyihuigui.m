clear all;
close all;
P=1:30;
T=3*sin(P);
net=newgrnn(P,T,0.3);
y=sim(net,P);
figure;
plot(P,T,':+',P,T-y,'-o');