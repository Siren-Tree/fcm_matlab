clear;
clc;
close all;
% data=cell2mat(struct2cell(load('.\uci\vowel.mat')));
% group=cell2mat(struct2cell(load('.\uci\vowelGroup.mat')));
% cluster_n=11;
data1=load(['ds6.mat']) ;
data=getfield (data1, 'dataSet');
group=getfield (data1, 'label');
cluster_n=size(unique(group),1);% 最终聚类的个数
m=3;
[center, U,J]=my_fcm(data,cluster_n,m);
[~,I]=max(U);
DB = getDB(data, I)
[precision,recall,FMeasure,Accuracy] = Fmeasure(group',I)

subplot(1,2,1);gscatter(data(:,1),data(:,2),group);
subplot(1,2,2);gscatter(data(:,1),data(:,2),I);