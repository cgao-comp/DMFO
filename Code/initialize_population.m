function [pop,flames]= initialize_population(N,el,adj_mat,V,clu)
global idealp;
% N ：种群大小
% el：边列表
% adj_mat：网络的邻接矩阵
% V：网络的节点数
particle.Position=[];
particle.Fitness=[];
% particle.Pbest.Position=[];
% particle.Pbest.Fitness=[];
pop = repmat(particle,N,1);
% flame.Position=[];
% flame.Fitness=[];
% flames = repmat(flame,N,1);
f = [];
for i=1:N
    pop(i).Position=PGLP(V,el); % 通过图标签传播算法进行初始化   
    pop(i).Fitness=evaluate_objective(pop(i).Position,adj_mat); 
%     pop(i).Pbest.Position=pop(i).Position;
%     pop(i).Pbest.Fitness=pop(i).Fitness;
%     flames(i).Position = pop(i).Position;
%     flames(i).Fitness = pop(i).Fitness;
    f = [f;pop(i).Fitness];
end
idealp = min(f); % 用于存储前面所有代最理想的两个目标值
end
