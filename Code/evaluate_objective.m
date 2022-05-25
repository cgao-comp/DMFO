function f = evaluate_objective(clu_assignment,adj_mat)
f=[];
f(1) = KKM(adj_mat,clu_assignment);
% f(1) = NRA(adj_mat,clu_assignment);
f(2) = RC(adj_mat,clu_assignment);
end
