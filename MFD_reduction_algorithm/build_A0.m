function A0 = build_A0(l)
% BUILD_A0 Constructs the block diagonal matrix A0 for minimal realization.
%
% INPUTS:
%   l - Vector of row degrees [l1, l2, ..., lp] where li is the degree of row i
%
% OUTPUT:
%   A0 - Block diagonal matrix where each block Ji is a companion-like matrix
%        of size (li x li) with ones on the super-diagonal
%
% DESCRIPTION:
%   This function builds the A0 matrix used in minimal realization of polynomial
%   matrices. For each degree li in the vector l, it creates a Jordan block Ji
%   of size (li-1 x li-1) with ones on the super-diagonal, then assembles these
%   blocks into a block diagonal matrix A0.
    
    A0 = [];
    for curr_grade = l
        % Create Jordan block with ones on the super-diagonal
        Ji = diag(ones(curr_grade-1,1),+1);
        % Add block to the block diagonal structure
        A0 = blkdiag(A0,Ji);
    end
end

