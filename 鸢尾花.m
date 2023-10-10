load fisheriris
X=meas(:,3:4);
Y=species;
figure;
g=gscatter(X(:,1),X(:,2),Y,'mrb','*po');
hold on;
a=gca;
lims=[a.XLim a.YLim];
title('{sandaintu}');
xlabel('花瓣长度(cm)');
ylabel('花瓣长度(cm)');
legend(g,{'setosa','versicolor','virginica'},'location','NW');
SVMModel=cell(3,1);
cls=unique(Y);
%%
rng(1);
for j=1:numel(cls)
    ind=strcmp(Y,cls(j));
    SVMModel{j}=fitcsvm(X,ind,'ClassNames',[false,true],'standardize',true,'KernelFunction','rbf',...
    'BoxConstraint',1);
end
%%
d=0.02;
[x1Grid,x2Grid]=meshgrid(min(X(:,1)):d:max(X(:,1)),min(X(:,2)):d:max(X(:,2)));
xGrid=[x1Grid(:),x2Grid(:)];
N=size(xGrid,1);
Scores=zeros(N,numel(cls));
for j=1:numel(cls);
    [~,score]=predict(SVMModel{j},xGrid);
    Scores(:,j)=score(:,2);
end
%%
[~,maxScore]=max(Scores,[],2);
Y2=cell(N,1);
for i=1:N
    Y2(i)=cls(maxScore(i));
end
%%
figure
h(1:3)=gscatter(xGrid(:,1),xGrid(:,2),maxScore,[0.1 0.5 0.5;0.5 0.1 0.5;0.5 0.5 0.1]);
hold on
h(4:6)=gscatter(X(:,1),X(:,2),Y,'mrb','*po');
title('{属植物分类区域}');
xlabel('花瓣长度(cm)');
ylabel('花瓣宽度(cm)');
legend(h,{'setosa region','versicolor region','virginica region','observed setosa',...
    'observed versicolor','observed virginica'},'Location','NW');
axis tight
hold on
