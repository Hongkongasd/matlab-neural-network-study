clear all;close all;
P=[1.1 2.2 3.1 4.1];
T=[2.2 4.02 5.8 8.1];
lr=maxlinlr(P);
net=newlin(minmax(P),1,0,lr);
net.trainParam.epochs=500; %ѵ������
net.trainParam.goal=0.04; %���Ҫ��
net=train(net,P,T);
Y=sim(net,P);
%%
clear all;
close all;
t=0:pi/10:4*pi;
X=t.*sin(t);
T=2*X+3;
figure;
plot(t,X,'+-',t,T,'+--');
legend('ϵͳ����','ϵͳ���');
set(gca,'xlim',[0 4*pi]);
set(gcf,'position',[50,50,400,400]);
net=newlind(X,T);
y=sim(net,X);
figure;
plot(t,y,'+:',t,y-T,'r:');

