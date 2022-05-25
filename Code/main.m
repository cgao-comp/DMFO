clc;
clear all;
fprintf('实验开始，请稍等！\n');
for num = 1:10

    fprintf('run %u finished:\t', num);
    [max_modularity,max_nmi,itch] = MODMFO();
    
    fprintf('更新次数: %g \n', itch);
end

