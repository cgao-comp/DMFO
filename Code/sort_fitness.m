function [sorted_pop] = sort_fitness(pop , adj_mat)
global idealp ;

%% Ñ°ÕÒ×îÓÅ»ðÑæ
sorted_pop.Position = [];
sorted_pop.Fitness = [];
niche = 40;
popsize = size(pop,1);
[weights,neighbors] = init_weight(popsize, niche);
f = [];
for i = 1:popsize
    pop(i).Fitness = evaluate_objective(pop(i).Position,adj_mat);
    idealp = min([pop(i).Fitness; idealp]);
%     pop_df = decomposedFitness(weights(i,:), pop(i).Fitness, idealp);
    mod = modularity(adj_mat,pop(i).Position);
%     f(i)= pop_df;
    f(i)= mod;
end

[fitness_sorted index] = sort(f,'descend');

for i = 1 : popsize
    sorted_pop(i,:).Position = pop(index(i)).Position;
    sorted_pop(i,:).Fitness = pop(index(i)).Fitness;
end
