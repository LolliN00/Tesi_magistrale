function P_lr = build_Plr(D, l)
    % Calcola P_lr dal residuo R e dai gradi di riga l
    syms s
    S = build_S_matrix(D,l);
    P_hr = calculate_leading_row_matrix(D);
    R = D-S*P_hr;
    [m_rows, n_cols] = size(R);
    total_rows = sum(l);
    P_lr = sym(zeros(total_rows, n_cols));
    
    current_row = 1;
    for i = 1:m_rows
        for degree = l(i)-1 : -1 : 0
            for j = 1:n_cols
                P_lr(current_row, j) = feval(symengine, 'coeff', R(i,j), s, degree);
            end
            current_row = current_row + 1;
        end
    end
end
