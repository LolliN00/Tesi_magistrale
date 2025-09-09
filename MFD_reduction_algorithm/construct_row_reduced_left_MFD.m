function [D_l,N_l,G] = construct_row_reduced_left_MFD(H)
% CONSTRUCT_ROW_REDUCED_LEFT_MFD Constructs row-reduced left MFD from transfer function.
%
% INPUTS:
%   H - Rational transfer function matrix (symbolic)
%
% OUTPUTS:
%   D_l - Row-reduced left denominator polynomial matrix
%   N_l - Corresponding left numerator polynomial matrix
%   G   - Transfer function matrix G = D_l^(-1) * N_l (should equal H)
%
% DESCRIPTION:
%   This function constructs a row-reduced left Matrix Fraction Description (MFD)
%   from a given rational transfer function matrix H. The algorithm follows these steps:
%   1. Compute initial MFD by clearing denominators using LCM
%   2. Calculate left coprime factorization of the initial MFD
%   3. Apply row reduction algorithm to obtain row-reduced form
%   4. Transform both D_l and N_l using the same unimodular matrix U
%   5. Verify the result by computing G = D_l^(-1) * N_l

    % Step 1: Compute initial MFD by clearing denominators
    [N_inital,~,D_initial] = calculate_lcm_and_initial_MFD(H);
    % Step 2: Calculate left coprime representation
    [D_lc,N_lc,~] = calculate_left_coprime_rapresentation(D_initial,N_inital);
    % Step 3: Apply row reduction to denominator matrix
    [U,D_l] = calculate_row_reduced_form(D_lc);
    % Step 4: Apply same transformation to numerator matrix
    N_l = U*N_lc;
    % Step 5: Compute final transfer function for verification
    G = D_l\N_l;
end

