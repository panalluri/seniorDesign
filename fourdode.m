function fourdode

[filename,pathname]=uigetfile('*.nrrd','Select Files', 'MultiSelect', 'on');
data = nrrdread(fullfile(pathname,filename));
data = double(data);

data = data(1:10,1:10,1:10,:);
A = size(data);
K = zeros(A(1),A(2),A(3));
Ct = K;
C_temp = K;

Cp = 0;
ve = 0.95;
dm = 1;
time = 0;
kval = 0;
dats = zeros(1,A(4));

for i = 1:A(1)
    for j = 1:A(2)
        for k = 1:A(3)
            dats = data(i,j,k,:);
            fun = @(x) find_k(x,dats);
            [x, fval] = fminbnd(fun,0,1000);
            K(i,j,k) = x;
            disp(x);
        end
    end
end

end