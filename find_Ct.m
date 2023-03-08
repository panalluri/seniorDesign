function f = find_Ct(x, dat, l)

time = l - (1:l);
f = dat - x * 1 * dot(gampdf(1:l,2.5,4.5), exp(-x .* time ./ 0.95)); %dm=1, ve=0.95   

end