function P_lr = build_Plr(D, l)
% BUILD_PLR Constructs the P_lr matrix from polynomial matrix D and row degrees l.
%
% INPUTS:
%   D - Polynomial matrix (symbolic)
%   l - Vector of row degrees [l1, l2, ..., lp] where li is the degree of row i
%
% OUTPUT:
%   P_lr - Lower-rank coefficient matrix of size (sum(l) x n_cols)
%          containing coefficients of the residual matrix R = D - S*P_hr
%
% DESCRIPTION:
%   This function computes P_lr by first calculating the residual matrix
%   R = D - S*P_hr, where S is the diagonal matrix with s^li terms and P_hr
%   is the leading row coefficient matrix. Then it extracts coefficients of
%   each polynomial entry in R for degrees from (li-1) down to 0, organizing
%   them row-wise in the output matrix P_lr.

    syms s
    % Build the diagonal matrix S with s^li terms
    S = build_S_matrix(D,l);
    % Calculate the leading row coefficient matrix
    P_hr = calculate_leading_row_matrix(D);
    % Compute the residual matrix R = D - S*P_hr
    R = D-S*P_hr;
    [m_rows, n_cols] = size(R);
    total_rows = sum(l);
    P_lr = sym(zeros(total_rows, n_cols));
    
    current_row = 1;
    % Extract coefficients from residual matrix R
    for i = 1:m_rows
        % For each row i, extract coefficients for degrees (li-1) down to 0
        for degree = l(i)-1 : -1 : 0
            for j = 1:n_cols
                % Extract coefficient of s^degree from R(i,j)
                P_lr(current_row, j) = feval(symengine, 'coeff', R(i,j), s, degree);
            end
            current_row = current_row + 1;
        end
    end
end
