function M_rr = calculate_leading_row_matrix(M)
% CALCULATE_LEADING_ROW_MATRIX Computes the row-leading coefficient matrix.
%
% INPUTS:
%   M - Polynomial matrix (symbolic)
%
% OUTPUT:
%   M_rr - Row-leading coefficient matrix where M_rr(i,j) contains the
%          coefficient of the highest-degree term in row i at the degree
%          corresponding to the maximum degree of row i
%
% DESCRIPTION:
%   This function calculates the row-leading coefficient matrix by transposing
%   the input matrix, computing the column-leading coefficient matrix of the
%   transpose, and then transposing the result back. This effectively extracts
%   the leading coefficients of each row based on the highest degree terms.

    % Transpose, calculate column-leading matrix, then transpose back
    M_cr = calculate_leading_col_matrix(M.');
    M_rr = M_cr';
end
