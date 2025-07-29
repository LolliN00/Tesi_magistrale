function M_hc = calculate_leading_col_matrix(M)
% Calcola la matrice dei coefficienti principali per colonne (restituisce una matrice simbolica)
    syms s
    [p, m] = size(M);
    M_hc = sym(zeros(p, m)); 
    
    for j = 1:m
        k_j = calculate_vector_degree(M(:,j));
        
        if isfinite(k_j) && k_j >= 0
            for i = 1:p
                if M(i,j) ~= 0
                    [c, t] = coeffs(M(i,j), s, 'All');
                    
                    degrees = zeros(size(t));
                    for k = 1:length(t)
                        if t(k) == 1
                            degrees(k) = 0;
                        else
                            degrees(k) = polynomialDegree(t(k), s);
                        end
                    end
                    
                    idx = find(degrees == k_j, 1);
                    if ~isempty(idx)
                        % 2. MODIFICA: Rimuovi la conversione a double
                        M_hc(i,j) = c(idx);
                    end
                end
            end
        end
    end
end