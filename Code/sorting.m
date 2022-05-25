function [X] = sorting(X)
    flag = 1;
    tempX = X;
    for i = 1 : length(X)
        if tempX(i) ~= -1
             for j = i + 1 : length(X)
                 if  tempX(i) ==  tempX(j)
                     X(j) = flag;
                     tempX(j) = -1;
                 end
             end
              tempX(i) = -1;
              X(i) = flag;
              flag  = flag + 1;
        end
    end
end



