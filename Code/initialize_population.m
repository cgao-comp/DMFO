function [pop,flames]= initialize_population(N,el,adj_mat,V,clu)
global idealp;
% N ����Ⱥ��С
% el�����б�
% adj_mat��������ڽӾ���
% V������Ľڵ���
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
    pop(i).Position=PGLP(V,el); % ͨ��ͼ��ǩ�����㷨���г�ʼ��   
    pop(i).Fitness=evaluate_objective(pop(i).Position,adj_mat); 
%     pop(i).Pbest.Position=pop(i).Position;
%     pop(i).Pbest.Fitness=pop(i).Fitness;
%     flames(i).Position = pop(i).Position;
%     flames(i).Fitness = pop(i).Fitness;
    f = [f;pop(i).Fitness];
end
idealp = min(f); % ���ڴ洢ǰ�����д������������Ŀ��ֵ
end
