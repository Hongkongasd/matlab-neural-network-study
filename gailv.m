clear all;
close all;
P=[1:8];
Tc=[2 3 1 2 3 2 1 1];
T=ind2vec(Tc);
net=newpnn(P,T);
Y=sim(net,P);
Yc=vec2ind(Y);