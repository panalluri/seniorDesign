function SD_boxPlotGeneration

%section K_trans matrix
K_trans = load('save_K.mat');
K_trans = cell2mat(struct2cell(K_trans));
A = size(K_trans);
n = 8;
x_step = (A(1) - mod(A(1), n)) / n;
y_step = (A(2) - mod(A(2), n)) / n;
z_step = (A(3) - mod(A(3), n)) / n;
x_range = [1:x_step:A(1) A(1)];
y_range = [1:y_step:A(2) A(2)];
z_range = [1:z_step:A(3) A(3)];
means = [];

%find avg K_trans values
for i = 1:length(x_range)-1
    for j = 1:length(y_range)-1
        for k = 1:length(z_range)-1
            K_temp = K_trans(x_range(i):x_range(i+1), y_range(j):y_range(j+1), z_range(k):z_range(k+1));
            means = [means mean(K_temp, 'all')];
            if mean(K_temp, 'all') > 800 %to find which submatrices the tumors live in
                disp("i = " + x_range(i) + ", j = " + y_range(j) + ", k = " + z_range(k));
            end
        end
    end
end

%plot boxplot
figure;
boxplot(means);
set(findobj('Tag','Box'),'LineWidth',3,'Color','r');
set(findobj('Tag','Median'),'LineWidth',3,'Color','r');
set(findobj('Tag','Upper Whisker'),'LineWidth',3,'Color','r');
set(findobj('Tag','Lower Whisker'),'LineWidth',3,'Color','r');
set(findobj('Tag','Lower Adjacent Value'),'LineWidth',3,'Color','r');
set(findobj('Tag','Upper Adjacent Value'),'LineWidth',3,'Color','r');
hold on;
swarmchart(ones(size(means)),means);
ylabel('Average K^{trans} Values');
title('K^{trans} Intensities');

figure;
image = imagesc(K_trans(:,:,65));
colormap gray;

end