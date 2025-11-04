function [N_initial,result_lcm,D_initial] = calculate_lcm_and_initial_MFD(M)
% CALCULATE_LCM_AND_INITIAL_MFD Computes initial MFD from rational matrix M.
%
% INPUTS:
%   M - Rational matrix (symbolic) with polynomial entries in numerator/denominator form
%
% OUTPUTS:
%   N_initial  - Initial numerator polynomial matrix
%   result_lcm - Least common multiple of all denominators in M
%   D_initial  - Initial denominator matrix (diagonal with LCM on diagonal)
%
% DESCRIPTION:
%   This function computes an initial Matrix Fraction Description (MFD) from
%   a rational transfer function matrix M. It finds the LCM of all denominators
%   in M, then constructs the initial MFD as M = D_initial^(-1) * N_initial,
%   where D_initial is a diagonal matrix with the LCM on the diagonal and
%   N_initial = M * LCM contains only polynomial entries.

    syms s;
    % Extract denominators from rational matrix M
    [~, D] = numden(M);
    denominators = D(:).';
    % Calculate least common multiple of all denominators
    result_lcm = lcm(denominators);
    % Create diagonal denominator matrix with LCM
    D_initial = simplify(eye(size(M,2))*result_lcm);
    % Calculate numerator matrix by clearing denominators
    N_initial = simplify(M*result_lcm);
end

