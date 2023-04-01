function fourdode

% [filename,pathname]=uigetfile('*.nrrd','Select Files', 'MultiSelect', 'on');
data = nrrdread(fullfile('C:\Users\Prani\caam496\','dcedata.nrrd'));
data = double(data);
imagesc(data(:,:,10,20)); %plot 2D slice of image   

data = data(1:7,1:7,1:7,:);
%data = data(:,100:end,:,:);
%data = data(100:200,100:250,10:12,:);
A = size(data);
A4 = A(4);
A3 = A(3);
K = zeros(A(1),A(2),A(3));
Ct = zeros(A(1),A(2),A(3),A(4));
gammaPDF = gampdf(1:A4,2.5,4.5);
options = optimset('TolX',1e-5,'MaxIter',500); %default tol=1e-4, maxiter=500

for i = 1:A(1)
    parfor j = 1:A(2)
        for k = 1:A3
            dats = data(i,j,k,:);
            fun = @(x) find_k(x,dats,gammaPDF);
            [x,~] = fminbnd(fun,0,1000,options);
            K(i,j,k) = x;
            %disp(x);
            for l = 1:A4
                disp("i = " + i + ", j = " + j + ", k = " + k + ", l = " + l);
                Ct(i,j,k,l) = find_Ct(x, dats(l), l, gammaPDF);
            end
        end
    end
end
disp(K);

L2 = sqrt(sum(sum(sum(sum(abs(data - Ct).^2)))));
disp("L2: " + L2);

%qualitative 2D C_t to data comparison
figure;
imagesc(data(:,:,1,1));
figure;
imagesc(Ct(:,:,1,1));

%compare for one element of C_t
figure;
Ct_elem = Ct(3,3,3,:);
plot(1:A(4),Ct_elem(:));
hold on;
dat_elem = data(3,3,3,:);
plot(1:A(4),dat_elem(:));
legend('C_t','data');

%max intensity image
Ct_max = zeros(A(1),A(2),A(3));
for i = 1:A(1)
    for j = 1:A(2)
        for k = 1:A(3)
            Ct_max(i,j,k) = max(Ct(i,j,k,:));
        end
    end
end
figure;
imagesc(Ct_max(:,:,1)); %one slice of max intensity image
imshow3Dfull(Ct_max);

%plot a slice of K matrix
figure;
imagesc(K(:,:,1));
imshow3Dfull(K);

end