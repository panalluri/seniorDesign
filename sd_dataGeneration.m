function sd_dataGeneration

Ct_max = load('save_Ct_max.mat');
Ct_max = cell2mat(struct2cell(Ct_max));
A = size(Ct_max);
figure;
image = imagesc(Ct_max(:,:,97));
colormap gray;

end