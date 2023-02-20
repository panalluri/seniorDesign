function f = find_k(x, dats)

f = 0;
for l = 1:length(dats)
    time = l - (1:l);
    f = f + (dats(l) - x * 1 * dot(gampdf(1:l,2.5,4.5), exp(-x .* time ./ 0.95)) ); %dm=1, ve=0.95   
end  
f = x * f^2;

end