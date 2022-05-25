% function [max_modularity,max_nmi,itch] = MODMFO()
clc; clear all;
tic
%%%% Load network data represented in adjacency matrix.
% load('Datasets\adjmat_karate_undirected.mat');
% load('Datasets\adjmat_dolphins_undirected.mat');
load('Datasets\adjmat_football_undirected.mat');
% load('Datasets\adjmat_polbooks_undirected.mat');
% load('Datasets\SFI_Adj.mat');
% adj_mat = SFI;
% load('Datasets\email.mat');
% adj_mat = b;
% load('Datasets\netscience.mat');
% adj_mat = b;
% load('Datasets\power.mat');
% adj_mat = b;
% clu_assignment_real = [];

[V,~] = size(adj_mat);
edgeslist = edges_list(adj_mat,V);
nArchive = 100; %���ķ�֧������
M = 2;          %%%M-objective Problems(����Ŀ�꺯��)
popsize = 100;  %%%partial swarm size
niche = 40;     %%%Neighbor size
Max_iteration = 100;   %%%Maximum number of generations
pm = 0.4;        %%%Mutation Probability
%%%%%%%%%%%%%%%%%%%%
global idealp neighbors weights itch;
% global idealp  itch;
itch = 0;
idealp = -Inf * ones(1,M);%%% ���ڴ洢��õĶ�Ŀ����Ӧ��

[weights,neighbors] = init_weight(popsize, niche);
[population ,best_flames] = initialize_population(popsize,edgeslist,adj_mat,V);  % Initiallization
EA = []; % ���ڴ洢��֧���

% Main loop
for Iteration = 1 : Max_iteration
   %% ���ڸ��»���
%     best_flames = updateflame(population, best_flames, adj_mat);
       
    % update Number of flames
%     Flame_no=round(popsize-Iteration*((popsize-1)/Max_iteration));
    % Flame_no=round(popsize-Iteration*((popsize-1)/(2*Max_iteration)));
    Flame_no = round(popsize-Iteration/3);
%     Flame_no = popsize;
    
    previous_population=population;    
%% ��Ⱥ��������
    % a linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a=-1+Iteration*((-1)/Max_iteration);
%     a=-2;
    for i=1:popsize
        if i<= Flame_no % Update the position of the moth with respect to its corresponsing flame
            % D in Eq. (3.13) 
            d_xor = (best_flames(i).Position ~= population(i).Position);            
            population(i).Position = updatePosition(best_flames(i).Position,...
                population(i).Position,edgeslist,a,d_xor);   
        end
        if i>Flame_no % Upaate the position of the moth with respct to one flame
            % Eq. (3.13)
            d_xor = (best_flames(Flame_no).Position ~= population(i).Position);
            population(i).Position = updatePosition(best_flames(Flame_no).Position,...
                population(i).Position,edgeslist,a,d_xor);
        end
        
       %% �������ɵĸ�����б���
%         if Iteration < pm * Max_iteration
        if rand < pm
            population(i).Position = mutation(population(i).Position,pm,edgeslist);
            population(i).Fitness = evaluate_objective(population(i).Position,adj_mat);
        end
        
        %% ���¸������Ӧ��
        population(i).Fitness = evaluate_objective(population(i).Position,adj_mat);
        
        %% �������еķɶ���壬�鿴�����Ƿ�����ԭ���ĸ���
        g = decomposedFitness(weights(i,:), population(i).Fitness, idealp);
        pre_g = decomposedFitness(weights(i,:), previous_population(i).Fitness, idealp);
        if g > pre_g
            population(i).Position = previous_population(i).Position;
            population(i).Fitness = previous_population(i).Fitness;
        end

       %% ���������������
        for k = neighbors(i,:) %
            g = decomposedFitness(weights(k,:), population(i).Fitness, idealp);
            g_n = decomposedFitness(weights(k,:), population(k).Fitness, idealp);
            if g < g_n
                population(k).Position = population(i).Position;
                population(k).Fitness = population(i).Fitness;
            end
        end
      %% ����PBHS ��
        f = decomposedFitness(weights(i,:), population(i).Fitness, idealp);
        pbest_fit = decomposedFitness(weights(i,:), best_flames(i).Fitness, idealp);
        if f < pbest_fit
            best_flames(i).Position = population(i).Position;
            best_flames(i).Fitness = population(i).Fitness;
        end
  
       %% ����z*
        idealp = min([population(i).Fitness;idealp]);
    
       %% Ѱ�ҷ�֧���
        if isempty(EA)
            EA = [EA population(i)];
        else
            isDominate = 0;
            rmindex = [];
            for k = 1 : numel(EA)
                if dominates(population(i),EA(k))
                    rmindex = [rmindex k];
                elseif dominates(EA(k),population(i))
                    isDominate = 1;
                end
            end
            % �Ƴ����б�population(i)֧�������
            EA(rmindex) = [];

            % ��population(i)�Ƿ�֧��������EP��
            if ~isDominate
                EA = [EA population(i)];
            end

            % �������Ĵ洢�ռ䣬�����ѡ��ɾ������ĸ���
            if numel(EA) > nArchive
                Extra = numel(EA)- nArchive;
                ToBeDeleted = randperm(numel(EA),Extra);
                EA(ToBeDeleted) = [];
            end
        end
    end 
  
    % �������ʱ��
    fprintf('iteration %u finished, time used: %u\n', Iteration, toc);
end
   
fronts = [];
for value = EA
    fronts = [fronts;value.Fitness];
end

[front,Index,~] = unique(fronts,'rows');
numfront = size(front,1);
modnmi = zeros(numfront,2);
for j = 1 : numfront
    modnmi(j,1) = modularity(adj_mat,EA(Index(j)).Position);
    modnmi(j,2) = normalized_mutual_information(clu_assignment_real,EA(Index(j)).Position);
end

[max_modularity,max_index1] = max(modnmi(:,1));
[max_nmi,max_index2] = max(modnmi(:,2));
fprintf('maxQ =  %g\t\t',max_modularity);
fprintf('maxNMI= %g\t',max_nmi);