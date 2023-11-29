clc;clear
load fisheriris  %�������ݿ�
X=meas(:,:);   %ȡ�ֱ�����ֵ
Y=species;       %��ǩֵ
% figure;
% g=gscatter(X(:,1),X(:,2),Y,'mrb','*po');%gscatter(X(:,1),X(:,2),�����ǩ��,����ɫ��,����״��)
% hold on;
% a=gca;           %��ȡ��ǰ�������������
% lims=[a.XLim a.YLim];
% title('{sandaintu}');
% xlabel('���곤��(cm)');
% ylabel('���곤��(cm)');
% legend(g,{'setosa','versicolor','virginica'},'location','NW');
SVMModel=cell(3,1);  %����������ѵ��ģ������
cls=unique(Y);       %ȥ��Y�ظ�ֵ
temp = randperm(150);
y=zeros(numel(Y),1);
for j=1:numel(cls)
    for i=1:numel(Y)
       if strcmp(Y(i),cls(j));
          y(i)=j; 
       end
    end
end
P_train = X(temp(1: 100), :);
T_train = y(temp(1: 100), :);
Y1=Y(temp(1:100),:);
M = size(P_train, 1);

P_test = X(temp(101: end), :);
T_test = y(temp(101: end), :);
N = size(P_test, 1);
%%
rng(1);   %�������ظ���
%����Ϊ������������񣬲�����ģ��ѵ��
for j=1:numel(cls)
    ind=strcmp(Y1,cls(j));
    SVMModel{j}=fitcsvm(P_train,ind,'ClassNames',[false,true],'standardize',true,'KernelFunction','rbf',...
    'BoxConstraint',1);
end

%%
%������������
% d=0.02;
% [x1Grid,x2Grid]=meshgrid(min(X(:,1)):d:max(X(:,1)),min(X(:,2)):d:max(X(:,2)));
% xGrid=[x1Grid(:),x2Grid(:)];
% N=size(xGrid,1);
% Scores=zeros(N,numel(cls));
Scores1=zeros(M,numel(cls));
Scores2=zeros(N,numel(cls));
%Ӧ��ѵ����ģ�ͶԲ������ݽ��д�֣�������Ը�������
for j=1:numel(cls);
    [~,score]=predict(SVMModel{j},P_train);
    Scores1(:,j)=score(:,2);
end
for j=1:numel(cls);
    [~,score]=predict(SVMModel{j},P_test);
    Scores2(:,j)=score(:,2);
end
%%
%�ҳ���������𣨼���������
[~,maxScore1]=max(Scores1,[],2);
[~,maxScore2]=max(Scores2,[],2);
% Y2=cell(N,1);
% for i=1:N
%     Y2(i)=cls(maxScore(i));
% end
error1=sum((T_train==maxScore1))/M*100;
error2=sum((T_test==maxScore2))/N*100;
%%  ��������
[T_train, index_1] = sort(T_train);
[T_test , index_2] = sort(T_test );

maxScore1 = maxScore1(index_1);
maxScore2 = maxScore2(index_2);
%%
% figure
% h(1:3)=gscatter(xGrid(:,1),xGrid(:,2),maxScore,[0.1 0.5 0.5;0.5 0.1 0.5;0.5 0.5 0.1]);
% hold on
% h(4:6)=gscatter(X(:,1),X(:,2),Y,'mrb','*po');
% title('{��ֲ���������}');
% xlabel('���곤��(cm)');
% ylabel('������(cm)');
% legend(h,{'setosa region','versicolor region','virginica region','observed setosa',...
%     'observed versicolor','observed virginica'},'Location','NW');
% axis tight
% hold on

figure
plot(1: M, T_train, 'r-*', 1: M, maxScore1, 'b-o', 'LineWidth', 1)
legend('��ʵֵ', 'Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('Ԥ����')
string = {'ѵ����Ԥ�����Ա�'; ['׼ȷ��=' num2str(error1) '%']};
title(string)
grid

figure
plot(1: N, T_test, 'r-*', 1: N, maxScore2, 'b-o', 'LineWidth', 1)
legend('��ʵֵ', 'Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('Ԥ����')
string = {'���Լ�Ԥ�����Ա�'; ['׼ȷ��=' num2str(error2) '%']};
title(string)
grid