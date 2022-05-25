function [et] = edges_list(A,V)
%EDGELIST Generate the edges list for each node.
%%% et(i).e:用于存放与节点 i 有边的节点
%%% et(i).n:用于存放节点 i 具有多少邻接点
et = [];
for i = 1:V
    et(i).e = [];
    et(i).n = 0;
    for j = 1:V
        if (A(i,j) == 1)
            et(i).e = [et(i).e j];
            et(i).n = et(i).n + 1;
        end
    end   
end
end