function M_cr = calculate_column_reduced_form(M)
    
% Riduzione per colonne di una matrice polinomiale M
    syms s
    if rank(M) ~= size(M, 2)
        error('The input matrix must have full column rank');
    end
    % ---- 1. leading-column matrix --------------------------------------
    leading_M = calculate_leading_col_matrix(M);

    % se il rango è già pieno → forma ridotta
    if rank(leading_M) == size(M,2)
        M_cr = M;
        return
    end

    % ---- 2. vettore di dipendenza   M_hc * a_tilde = 0 ------------------
    K = null(leading_M);            % base del nucleo
    % Prendiamo il primo vettore della base
    a_tilde =  K(:,1);
    k_j = -inf;   j_col = -1;
    for i = 1:length(a_tilde)
        if a_tilde(i) ~= 0
            deg_i = calculate_vector_degree(M(:,i)); 
            if deg_i > k_j
                k_j   = deg_i;
                j_col = i;
            end
        end
    end

    % ---- 4. costruisci il vettore polinomiale a(z) ----------------------
    a = sym(zeros(size(M,2),1));
    for i = 1:length(a)
        exp_shift = k_j - calculate_vector_degree(M(:,i));
        a(i) = a_tilde(i) * s^exp_shift;              % esp_shift >= 0
    end
    % ---- 5. matrice unimodulare elementare U ---------------------------
    U = sym(eye(size(M,2)));         % identità
    U(:, j_col) = a;                 % sostituisci la colonna j
    % ---- 6. aggiorna la matrice ----------------------------------------
    M_bar = (M * U);           
    leading_bar = calculate_leading_col_matrix(M_bar);
    % ---- 7. test di arresto / ricorsione -------------------------------
    if rank(leading_bar) == size(M,2)
        M_cr = M_bar;
    else
        M_cr = calculate_column_reduced_form(M_bar);
    end
end
