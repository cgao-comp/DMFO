function [sorted_pop] = select_flame(pop,flame ,adj_mat,edgeslist)
global idealp neighbors weights;
niche = 40;
pm = 0.3;
% ff_de = [];%���ڴ洢�ֽ���Ӧ��
%��������Ѱ�����ŵĻ���
popsize = size(pop,1);
pc = 0.9;
for i = 1:popsize
 %% ������������ж�·����
    if rand < pc
        % ����ѡ��һ���ھӸ�����ø�����ж�·����
        [k] = randperm(niche,1);
        x_k = neighbors(i,k);
        %���ѡ��һ���ڵ�
        [m] = randperm(size(flame(i).Position,2),2);
        k_m = flame(x_k).Position(1,m(1));
        l_m = flame(i).Position(1,m(2));
        [index_k] = find(flame(x_k).Position == k_m);%�ҵ���ǩΪk_m��λ��pop(x_k)�е�����Ԫ��
        [index_l] = find(flame(i).Position == l_m);
        k_position = flame(x_k).Position;
        l_position = flame(i).Position;
        l_position(index_k) = k_m;
        k_position(index_l) = l_m;
        l_position = sorting(l_position);
        k_position = sorting(k_position);
        l_fitness = evaluate_objective(l_position,adj_mat);
        k_fitness = evaluate_objective(k_position,adj_mat);
        k_g = decomposedFitness(weights(i,:), k_fitness, idealp);
        l_g = decomposedFitness(weights(i,:), l_fitness, idealp);
        i_g = flame(i).Fitness;    
        if k_g < l_g
            if k_g < i_g
                flame(i).Position = k_position;
                flame(i).Fitness = k_fitness;
            end
        else
            if l_g < i_g
                flame(i).Position = l_position;
                flame(i).Fitness = l_fitness;
            end    
        end
        idealp = min([flame(i).Fitness;idealp]);
    end
    %% ���б���
    if rand < pm
        mu_population(i).Position = mutation(flame(i).Position,pm,edgeslist);
        mu_population(i).Fitness = evaluate_objective(mu_population(i).Position,adj_mat);
        mu_g = decomposedFitness(weights(i,:), mu_population(i).Fitness, idealp);
        g = decomposedFitness(weights(i,:), flame(i).Fitness, idealp);
        if mu_g < g
            flame(i).Position = mu_population(i).Position;
            flame(i).Fitness = mu_population(i).Fitness;
            flame(i).Position = sorting(flame(i).Position);
        end
        idealp = min([flame(i).Fitness;idealp]);      
    end
    
%     pop_de = decomposedFitness(weights(i,:), pop(i).Fitness, idealp);
%     fl_de = decomposedFitness(weights(i,:), flame(i).Fitness, idealp);
%     if pop_de < fl_de
%         flame(i).Position = pop(i).Position;
%         flame(i).Fitness = pop(i).Fitness; 
%     end
%     ff_de(i) = fl_de; 
end
% sorted_pop = flame;
% 
% [fitness_sorted index] = sort(ff_de);
% 
% for i = 1 : popsize
%     sorted_pop(i,:).Position = flame(index(i)).Position;
%     sorted_pop(i,:).Fitness = flame(index(i)).Fitness;
% end

double_pop =[pop; flame];
sorted_pop = sort_fitness(double_pop,adj_mat);




