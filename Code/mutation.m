function x = mutation(x,pm,el)
n = length(x);
for i = 1 : n
    if rand < pm
        x(el(i).e) = x(i);
    end
end
x = sorting(x);
end


