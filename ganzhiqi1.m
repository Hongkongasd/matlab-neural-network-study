clear all;
close all;
P=[0 0 1 1;0 1 0 1];
T=[0 1 1 1];
net=newp(minmax(P),1,'hardlim','learnp');
net=train(net,P,T);
Y=sim(net,P);
plotpv(P,T);
plotpc(net.iw{1,1},net.b{1});