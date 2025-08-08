function Gamma = build_Gamma_matrix(l)


    syms s
    Gamma = sym(zeros(0));   % matrice vuota simbolica

    for li = l
        % blocco riga [s^(li-1) s^(li-2) ... 1]
        disp(li);
        block = sym(zeros(1, li));
        for k = 1:li
            block(k) = s^(li - k);
        end
        % metti in diagonale a blocchi
        Gamma = blkdiag(Gamma, block);
    end
end
