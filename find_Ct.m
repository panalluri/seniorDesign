function f = find_Ct(x, dat, l, gammaPDF)

time = l - (1:l);
f = dat - x * 1 * dot(gammaPDF(1:l), exp(-x .* time ./ 0.95)); %dm=1, ve=0.95   

end