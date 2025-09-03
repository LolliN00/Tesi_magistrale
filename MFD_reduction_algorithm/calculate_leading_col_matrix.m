function M_hc = calculate_leading_col_matrix(M)
% Calculates the column-leading coefficient matrix (M_hc) for a polynomial matrix M.
% Returns a symbolic matrix with the coefficient of the highest-degree term in each column.

    syms s
    [p, m] = size(M);
    M_hc = sym(zeros(p, m)); 

    for j = 1:m
        % Grado massimo della colonna j
        k_j = calculate_vector_degree(M(:,j));
        if k_j < 0
            continue; % colonna nulla → salta
        end
        for i = 1:p
            % Coefficiente di s^k_j in M(i,j)
            M_hc(i,j) = feval(symengine, 'coeff', M(i,j), s, k_j);
        end
    end
end
