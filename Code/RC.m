function [ cs ] = RC(adj_mat,clu_assignment)
% Compute the community score for each partition.
% adj_mat: the adjacency matrix of the network.
% clu_assignment: the cluster label vector.
clu_num = max(clu_assignment);
de=0;
cs=0;
for i = 1:clu_num
    s_index = find(clu_assignment == i);
    s = adj_mat(s_index,s_index);
    s_cardinality = length(s_index);
    kins_sum = 0;
    kouts_sum = 0;
    for j = 1:s_cardinality
        kins = sum(s(j,:));
        ksum = sum(adj_mat(s_index(j),:));
        kouts = ksum - kins;
        kins_sum = kins_sum + kins;
        kouts_sum = kouts_sum + kouts;
        de=kouts_sum;
    end
    cf_s = de*1.0/(s_cardinality);
    cs = cs + cf_s;
end
cs =cs;
end

