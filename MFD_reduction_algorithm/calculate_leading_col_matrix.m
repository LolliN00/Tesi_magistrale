function M_hc = calculate_leading_col_matrix(M)
% CALCULATE_LEADING_COL_MATRIX Computes the column-leading coefficient matrix.
%
% INPUTS:
%   M - Polynomial matrix (symbolic)
%
% OUTPUT:
%   M_hc - Column-leading coefficient matrix where M_hc(i,j) contains the
%          coefficient of the highest-degree term in column j at the degree
%          corresponding to the maximum degree of column j
%
% DESCRIPTION:
%   This function calculates the column-leading coefficient matrix for a polynomial
%   matrix M. For each column j, it first determines the maximum degree k_j among
%   all entries in that column. Then it extracts the coefficient of s^k_j from
%   each entry M(i,j) in that column. Zero columns (degree < 0) are skipped.

    syms s
    [p, m] = size(M);
    M_hc = sym(zeros(p, m)); 

    for j = 1:m
        % Find maximum degree of column j
        k_j = calculate_vector_degree(M(:,j));
        if k_j < 0
            continue; % Skip zero column
        end
        for i = 1:p
            % Extract coefficient of s^k_j from M(i,j)
            M_hc(i,j) = feval(symengine, 'coeff', M(i,j), s, k_j);
        end
    end
end
