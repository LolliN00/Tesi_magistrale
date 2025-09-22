function Gamma = build_Gamma_matrix(l)
% BUILD_GAMMA_MATRIX Constructs the Gamma matrix for polynomial transformation.
%
% INPUTS:
%   l - Vector of row degrees [l1, l2, ..., lp] where li is the degree of row i
%
% OUTPUT:
%   Gamma - Block diagonal symbolic matrix where each block is a row vector
%           [s^(li-1), s^(li-2), ..., s, 1] for degree li
%
% DESCRIPTION:
%   This function builds the Gamma matrix used in polynomial matrix factorization.
%   For each degree li in the vector l, it creates a row block containing powers
%   of the symbolic variable s in descending order: [s^(li-1), s^(li-2), ..., 1].
%   These blocks are then assembled into a block diagonal matrix structure.

    syms s
    Gamma = sym(zeros(0));   % Initialize empty symbolic matrix

    for li = l
        % Create row block [s^(li-1) s^(li-2) ... 1]
        block = sym(zeros(1, li));
        for k = 1:li
            % Fill block with descending powers of s
            block(k) = s^(li - k);
        end
        % Add block to the block diagonal structure
        Gamma = blkdiag(Gamma, block);
    end
end
