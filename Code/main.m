clc;
clear all;
fprintf('ʵ�鿪ʼ�����Եȣ�\n');
for num = 1:10

    fprintf('run %u finished:\t', num);
    [max_modularity,max_nmi,itch] = MODMFO();
    
    fprintf('���´���: %g \n', itch);
end

