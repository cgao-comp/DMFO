function b = dominates(x,y)
    if isfield(x,'Fitness') % �ж��Ƿ��ǽṹ���Ա
        x = x.Fitness;
    end
    if isfield(y,'Fitness')
        y = y.Fitness;
    end   
    b=all(x<=y) && any(x<y);
%     b=all(x<=y);
end