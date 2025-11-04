function S = build_S_matrix(D_l,l)
% BUILD_S_MATRIX Constructs the diagonal S matrix with polynomial powers.
%
% INPUTS:
%   D_l - Polynomial matrix (used only for size reference)
%   l   - Vector of row degrees [l1, l2, ..., lp] where li is the degree of row i
%
% OUTPUT:
%   S - Diagonal symbolic matrix of size p×p where S(i,i) = s^li
%
% DESCRIPTION:
%   This function creates a diagonal matrix S where each diagonal entry S(i,i)
%   contains the symbolic polynomial s^li, where li is the i-th element of the
%   degree vector l. This matrix is used in polynomial matrix factorization
%   and minimal realization algorithms.

    syms s;
    % Initialize diagonal matrix with zeros
    S = sym(zeros(size(D_l,1)));
    % Fill diagonal with polynomial powers s^li
    for i = 1:length(l)
        S(i,i) = s^l(i);
    end
end
