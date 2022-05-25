function x = updatePosition(f,x,el,a,d_xor)
global itch ;
n = length(x);
temp_x = x;
temp_f = f;
for i = 1 : n
    if d_xor(i) == 1       
        tt = (a-1)*rand+1;
%         sec = cos(tt.*2*pi)./tt;
        sec = abs(exp(tt).*cos(tt.*2*pi));
        sig = 1./(1 + exp(-sec));
        r = rand;
        if sig > r
            itch = itch+1;
            nb_size = el(i).n;
            if nb_size > 1
                nb_labels = temp_x(el(i).e);
                t = tabulate(nb_labels);
                max_nb_labels = t(t(:,2)==max(t(:,2)),1);
                x(i) = max_nb_labels(randi(length(max_nb_labels)));
            elseif nb_size == 1
                x(i) = temp_x(el(i).e);
            end
%         else
%             x(i) = f(i);
%             nb_size = el(i).n;
%             if nb_size > 1
%                 nb_labels = temp_x(el(i).e);
%                 t = tabulate(nb_labels);
%                 max_nb_labels = t(t(:,2)==max(t(:,2)),1);
%                 x(i) = max_nb_labels(randi(length(max_nb_labels)));
%             elseif nb_size == 1
%                 x(i) = temp_x(el(i).e);
%             end
        end
    end     
    
    x = sorting(x);
end







