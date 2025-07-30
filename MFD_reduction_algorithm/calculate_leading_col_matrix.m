function M_hc = calculate_leading_col_matrix(M)
% Calculates the column-leading coefficient matrix (M_hc) for a polynomial matrix M.
% The function returns a symbolic matrix.

    % Define the symbolic variable 's' for polynomials.
    syms s
    
    % Get the dimensions of the input matrix M.
    [p, m] = size(M);
    
    % Initialize the output matrix M_hc as a symbolic matrix of zeros.
    % This ensures the output can be rendered as LaTeX in Live Scripts.
    M_hc = sym(zeros(p, m)); 
    
    % Iterate over each column of the input matrix.
    for j = 1:m
        % Calculate the degree of the entire j-th column vector.
        k_j = calculate_vector_degree(M(:,j));
        
        % Proceed only if the column is not null (degree is finite and non-negative).
        if isfinite(k_j) && k_j >= 0
            % Iterate over each row to extract the correct coefficient from the j-th column.
            for i = 1:p
                % Process only non-zero polynomial elements.
                if M(i,j) ~= 0
                    % Get all coefficients 'c' and corresponding terms 't' of the polynomial M(i,j).
                    [c, t] = coeffs(M(i,j), s, 'All');
                    
                    % Determine the degree of each term found.
                    degrees = zeros(size(t));
                    for k = 1:length(t)
                        if t(k) == 1 % Handle the constant term (s^0).
                            degrees(k) = 0;
                        else
                            degrees(k) = polynomialDegree(t(k), s);
                        end
                    end
                    
                    % Find the index of the coefficient whose term has a degree equal to k_j.
                    idx = find(degrees == k_j, 1);
                    
                    % If a coefficient for the degree k_j exists, place it in the output matrix.
                    if ~isempty(idx)
                        % Assign the symbolic coefficient directly, without converting to double.
                        M_hc(i,j) = c(idx);
                    end
                    % If no such coefficient exists, the value in M_hc remains 0 from initialization.
                end
            end
        end
    end
end