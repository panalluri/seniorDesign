function ks = k_slice(z,data)
    A = size(data);
    ks = zeros(A(1),A(2));
    for i = 1:A(1)
        for j = 1:A(2)
            dats = data(i,j,z,:);
            fun = @(x) find_k(x,dats);
            ks(i,j) = fun([i,j,z]);
        end
    end
end