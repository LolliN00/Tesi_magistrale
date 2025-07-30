Of course, here is the commented code.

```matlab
function [U, M_rr] = calculate_row_reduced_form(M)
% Computes the row-reduced form of a polynomial matrix M.
% Returns the total unimodular transformation U and the row-reduced matrix M_rr.

    % Define the symbolic variable for the polynomials.
    syms s

    % Check for full row rank, a prerequisite for the algorithm.
    if rank(M) ~= size(M, 1)
        error('The input matrix must have full row rank');
    end
    
    % Calculate the row-leading coefficient matrix (M_hr).
    leading_M = calculate_leading_row_matrix(M);
    
    % Initialize the total unimodular transformation matrix U as identity.
    U = sym(eye(size(M, 1))); 
    
    % --- STOPPING CONDITION ---
    % If the leading matrix has full rank, M is already row-reduced.
    if rank(leading_M) == size(M, 1)
        M_rr = M;
        return
    end

    % --- REDUCTION STEP ---
    % Find a dependency vector in the left null space of the leading matrix.
    K = null(leading_M');  % K is a basis for the null space of M_hr'.
    a_tilde = K(:, 1).';   % Take the first basis vector as a 1xp row vector.

    % Find the row 'j_row' with the maximum degree among the "active" rows
    % (those corresponding to non-zero elements in a_tilde).
    k_j = -1;      % Stores the maximum degree found so far.
    j_row = -1;    % Stores the index of the row with the maximum degree.
    for i = 1:length(a_tilde)
        if a_tilde(i) ~= 0
            deg_i = calculate_vector_degree(M(i, :)); % Get degree of the i-th row.
            if deg_i > k_j
                k_j = deg_i;
                j_row = i;
            end
        end
    end
    
    % Build the polynomial row vector a(z) for the transformation.
    a = sym(zeros(1, size(M, 1))); % Initialize as a symbolic 1xp row vector.
    for i = 1:length(a)
        % Calculate the degree shift to align terms with the max degree k_j.
        exp_shift = k_j - calculate_vector_degree(M(i, :));
        if isinf(exp_shift) % Handle the case of a zero row (degree -inf).
            exp_shift = 0;
        end
        a(i) = a_tilde(i) * s^exp_shift;
    end
    
    % Construct the elementary unimodular matrix U for this single step
    % by replacing the j-th row of the identity matrix with a(z).
    U(j_row, :) = a; 
    
    % Update the matrix by pre-multiplying with U.
    M_bar = (U * M);
    
    % --- RECURSION ---
    % Check the leading coefficient matrix of the new matrix M_bar.
    leading_bar = calculate_leading_row_matrix(M_bar);
    
    % If M_bar is now row-reduced, the process is done for this branch.
    if rank(leading_bar) == size(M, 1)
        M_rr = M_bar;
    else 
        % Otherwise, apply the algorithm recursively to the new matrix.
        [U_rec, M_rr] = calculate_row_reduced_form(M_bar);
        % The final transformation U is the cumulative product of U's from each step.
        U = U_rec * U;
    end
end
```