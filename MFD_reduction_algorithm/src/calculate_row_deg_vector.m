function l = calculate_row_deg_vector(D_l)
% CALCULATE_ROW_DEG_VECTOR Computes the row degree vector of a polynomial matrix.
%
% INPUTS:
%   D_l - Polynomial matrix (symbolic)
%
% OUTPUT:
%   l - Row degree vector [l1, l2, ..., lp] where li is the degree of row i
%
% DESCRIPTION:
%   This function calculates the degree of each row in the polynomial matrix D_l.
%   The degree of a row is defined as the maximum degree among all polynomial
%   entries in that row. The result is a vector containing the row degrees,
%   which is essential for constructing minimal realizations and row-reduced forms.

    % Initialize row degree vector
    l = zeros(1,size(D_l,1));
    % Calculate degree for each row
    for i = 1:size(D_l,1)
        l(i) = calculate_vector_degree(D_l(i,:));
    end
end

