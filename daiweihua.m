clc;clear
load fisheriris  %载入数据库
X=meas(:,:);   %取分辨特征值
Y=species;       %标签值
% figure;
% g=gscatter(X(:,1),X(:,2),Y,'mrb','*po');%gscatter(X(:,1),X(:,2),分类标签集,‘颜色’,‘形状’)
% hold on;
% a=gca;           %获取当前坐标轴各项数据
% lims=[a.XLim a.YLim];
% title('{sandaintu}');
% xlabel('花瓣长度(cm)');
% ylabel('花瓣长度(cm)');
% legend(g,{'setosa','versicolor','virginica'},'location','NW');
SVMModel=cell(3,1);  %创建矩阵存放训练模型数据
cls=unique(Y);       %去除Y重复值
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
rng(1);   %？？可重复性
%划分为多个二分类任务，并进行模型训练
for j=1:numel(cls)
    ind=strcmp(Y1,cls(j));
    SVMModel{j}=fitcsvm(P_train,ind,'ClassNames',[false,true],'standardize',true,'KernelFunction','rbf',...
    'BoxConstraint',1);
end

%%
%创建测试数据
% d=0.02;
% [x1Grid,x2Grid]=meshgrid(min(X(:,1)):d:max(X(:,1)),min(X(:,2)):d:max(X(:,2)));
% xGrid=[x1Grid(:),x2Grid(:)];
% N=size(xGrid,1);
% Scores=zeros(N,numel(cls));
Scores1=zeros(M,numel(cls));
Scores2=zeros(N,numel(cls));
%应用训练后模型对测试数据进行打分，存入其对各类别分数
for j=1:numel(cls);
    [~,score]=predict(SVMModel{j},P_train);
    Scores1(:,j)=score(:,2);
end
for j=1:numel(cls);
    [~,score]=predict(SVMModel{j},P_test);
    Scores2(:,j)=score(:,2);
end
%%
%找出最大分数类别（即最符合类别）
[~,maxScore1]=max(Scores1,[],2);
[~,maxScore2]=max(Scores2,[],2);
% Y2=cell(N,1);
% for i=1:N
%     Y2(i)=cls(maxScore(i));
% end
error1=sum((T_train==maxScore1))/M*100;
error2=sum((T_test==maxScore2))/N*100;
%%  数据排序
[T_train, index_1] = sort(T_train);
[T_test , index_2] = sort(T_test );

maxScore1 = maxScore1(index_1);
maxScore2 = maxScore2(index_2);
%%
% figure
% h(1:3)=gscatter(xGrid(:,1),xGrid(:,2),maxScore,[0.1 0.5 0.5;0.5 0.1 0.5;0.5 0.5 0.1]);
% hold on
% h(4:6)=gscatter(X(:,1),X(:,2),Y,'mrb','*po');
% title('{属植物分类区域}');
% xlabel('花瓣长度(cm)');
% ylabel('花瓣宽度(cm)');
% legend(h,{'setosa region','versicolor region','virginica region','observed setosa',...
%     'observed versicolor','observed virginica'},'Location','NW');
% axis tight
% hold on

figure
plot(1: M, T_train, 'r-*', 1: M, maxScore1, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'训练集预测结果对比'; ['准确率=' num2str(error1) '%']};
title(string)
grid

figure
plot(1: N, T_test, 'r-*', 1: N, maxScore2, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'测试集预测结果对比'; ['准确率=' num2str(error2) '%']};
title(string)
grid