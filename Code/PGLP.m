function [x] = PGLP( node_num,el )
%%Population Generation via Label Propagation(PGLP)
x = 1:node_num;
x = perturbation(x);
iters = 5;
for i =1 : iters
    temp_x = x;
    for j = 1 : node_num
        nb_labels = temp_x(el(j).e);
        nb_size = el(j).n;
        if nb_size > 0
            t = tabulate(nb_labels); % 统计每个值的实例数量以及百分比
            max_nb_labels = t(t(:,2)==max(t(:,2)),1); % 选择领节点标签数最多的标签用于更新节点
            x(j) = max_nb_labels(randi(length(max_nb_labels))); % 从标签数最多的标签里面选择一个标签用于更新节点
        end
    end
end
x = sorting(x);%从小到大排序
end

function [x] = perturbation(x)
%将一个系列的元素顺序打乱
%%
n = length(x);
i = n;
while  i > 0
    index = randi(n);
    temp = x(i);
    x(i) = x(index);
    x(index) = temp;
    i = i - 1;
end
end