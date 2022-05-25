function tc_fit = decomposedFitness(weight,objectives,idealpoint )
weight((weight == 0)) = 0.00001;
part2 = abs(objectives-idealpoint);
tc_fit = max(weight.*part2,[],2);   
% tc_fit = max(part2./weight,[],2); 
end


