% function [] = ainc2adj()
clc,clear all;
clu = ['clu0.00.txt';'clu0.05.txt';'clu0.10.txt';'clu0.15.txt';'clu0.20.txt';...
    'clu0.25.txt';'clu0.30.txt';'clu0.35.txt';'clu0.40.txt';'clu0.45.txt';'clu0.50.txt'];
gn = ['gn0.00.txt'; 'gn0.05.txt';'gn0.10.txt';'gn0.15.txt';'gn0.20.txt';'gn0.25.txt';...
    'gn0.30.txt';'gn0.35.txt';'gn0.40.txt';'gn0.45.txt';'gn0.50.txt'];

for k = 1:length(clu) 
    x = textread(strcat('.\Datasets\gn-clu\',gn(k,:)));
    % 邻接表生成邻接矩阵
    if min(x)==0
        x = x+1;
    end
    d = length(x);
    a = max(max(x));
    b = zeros(a,a);
    for i =1:d
        if x(i,1) == x(i,2)
            b(x(i,1),x(i,2))=0;
        else
            b(x(i,1),x(i,2))=1;
            b(x(i,2),x(i,1))=1;
        end
    end
    % 存储每一个节点的社区号
    c = textread(strcat('.\Datasets\gn-clu\',clu(k,:)));
    c_d = length(c);
    b_c = zeros(1,c_d);
    for j = 1:c_d
        b_c(j) = c(j,2);
    end
    filename = strcat('.\Datasets\gn-clu\gn_',num2str(k));
    save(filename,'b','b_c');
end
% save b;