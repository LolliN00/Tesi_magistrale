function [N_initial,result_lcm,D_initial] = calculate_lcm_and_initial_MFD(M)
syms s;
[~, D] = numden(M);
denominators = D(:).';
result_lcm = lcm(denominators);
D_initial = simplify(eye(size(M,2))*result_lcm);
N_initial = simplify(M*result_lcm);
end

