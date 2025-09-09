function C0 = build_C0(l)
% BUILD_C0 Constructs the block diagonal matrix C0 for minimal realization.
%
% INPUTS:
%   l - Vector of row degrees [l1, l2, ..., lp] where li is the degree of row i
%
% OUTPUT:
%   C0 - Block diagonal matrix where each block c_i is a row vector
%        of length li with 1 in the first position and zeros elsewhere
%
% DESCRIPTION:
%   This function builds the C0 matrix used in minimal realization of polynomial
%   matrices. For each degree li in the vector l, it creates a row vector c_i
%   of length li with c_i(1) = 1 and all other elements zero, then assembles
%   these vectors into a block diagonal matrix C0.
    
    C0 = [];
    for curr_grade = l
        % Create row vector with 1 in first position, zeros elsewhere
        c_i = zeros(1,curr_grade);
        c_i(1) = 1;
        % Add block to the block diagonal structure
        C0 = blkdiag(C0,c_i);
    end
end

