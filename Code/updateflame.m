% function [flame] = updateflame(pop, flame, adj_mat,el)
function [flame] = updateflame(pop, flame, adj_mat)
global weights idealp;
%% 寻找最优火焰
popsize = size(pop,1);
f = [];

% dou_pop = [pop_best;flame];
% dou_popsize = size(dou_pop,1);

for i = 1:popsize
%     mod = modularity(adj_mat,dou_pop(i).Position);
%     pop(i).Fitness = evaluate_objective(pop(i).Position,adj_mat);
%     idealp = min([pop(i).Fitness; idealp]);
    pop_df = decomposedFitness(weights(i,:), pop(i).Pbest.Fitness, idealp);
    f_df = decomposedFitness(weights(i,:), flame(i).Fitness, idealp);
    
    if pop_df < f_df
        flame(i).Position = pop(i).Pbest.Position;
        flame(i).Fitness = pop(i).Pbest.Fitness;
    end
%     f(i)= mod;
%     flame(i).Position = pop(i).Pbest.Position;
%     flame(i).Fitness = pop(i).Pbest.Fitness;
end
% 
% [fit_sorted index] = sort(f,'descend');
% 
% for i = 1 : popsize
%     flame(i,:).Position = dou_pop(index(i)).Position;
%     flame(i,:).Fitness = dou_pop(index(i)).Fitness;
% end

%%
% global idealp weights;
% % 使用 DE算法进行更新
% popsize = 100;
% d = length(flame(1).Position);
% pbhs = pop;
% for j = 1:popsize
%    [p] = randperm(popsize,3);
%    pb1 = pbhs(p(1)).Pbest;
%    pb2 = pbhs(p(2)).Pbest;
%    pb3 = pbhs(p(3)).Pbest;
%    temp_p = pb1.Position;
%    dif = rand(1,d).*(pb2.Position ~= pb3.Position); 
%    for i = 1:d
%       if rand < dif(j)
%           nb_size = el(i).n;
%             if nb_size > 1
%                 nb_labels = temp_p(el(i).e);
%                 t = tabulate(nb_labels);
%                 max_nb_labels = t(t(:,2)==max(t(:,2)),1);
%                 pb1.Position(i) = max_nb_labels(randi(length(max_nb_labels)));
%             elseif nb_size == 1
%                 pb1.Position(i) = temp_p(el(i).e);
%             end          
%       end
%       pb1.Position = sorting(pb1.Position);  
%    end
%    fm_pos = pb1.Position;
%    fm_fit = evaluate_objective(fm_pos,adj_mat);
%    fm_d = decomposedFitness(weights(j,:), fm_fit, idealp);
%    f_d = decomposedFitness(weights(j,:), flame(j).Fitness, idealp);
%    if fm_d < f_d
%        flame(i).Position = fm_pos;
%        flame(i).Fitness = fm_fit;      
%    end
% end