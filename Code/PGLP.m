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
            t = tabulate(nb_labels); % ͳ��ÿ��ֵ��ʵ�������Լ��ٷֱ�
            max_nb_labels = t(t(:,2)==max(t(:,2)),1); % ѡ����ڵ��ǩ�����ı�ǩ���ڸ��½ڵ�
            x(j) = max_nb_labels(randi(length(max_nb_labels))); % �ӱ�ǩ�����ı�ǩ����ѡ��һ����ǩ���ڸ��½ڵ�
        end
    end
end
x = sorting(x);%��С��������
end

function [x] = perturbation(x)
%��һ��ϵ�е�Ԫ��˳�����
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