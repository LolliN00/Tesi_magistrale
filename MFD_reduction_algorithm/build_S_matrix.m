function S = build_S_matrix(l)
    syms s;
    S = sym(zeros(size(D_l,1)));
    for i = 1:length(l)
        S(i,i) = s^l(i);
    end
    
end
