function [A,B,C] = calculate_minimal_realization(D_l,N_l)
% CALCULATE_MINIMAL_REALIZATION Computes minimal state-space realization matrices.
%
% INPUTS:
%   D_l - Left denominator polynomial matrix (symbolic)
%   N_l - Left numerator polynomial matrix (symbolic)
%
% OUTPUTS:
%   A - State matrix of the minimal realization
%   B - Input matrix of the minimal realization
%   C - Output matrix of the minimal realization
%
% DESCRIPTION:
%   This function computes the minimal state-space realization (A,B,C) from
%   a left Matrix Fraction Description G(s) = D_l^(-1) * N_l. The algorithm:
%   1. Calculates row degrees of D_l
%   2. Builds companion-form matrices A_0 and C_0
%   3. Computes leading and lower coefficient matrices P_hr and P_lr
%   4. Constructs the minimal realization using the standard formulas:
%      A = A_0 - P_lr * P_hr^(-1) * C_0
%      B = Q_lr (coefficient matrix from N_l)
%      C = P_hr^(-1) * C_0

    % Calculate row degree vector from denominator matrix
    l = calculate_row_deg_vector(D_l);
    % Build companion-form matrices
    A_0 = build_A0(l);
    C_0 = build_C0(l);
    % Calculate leading and lower coefficient matrices
    P_hr = calculate_leading_row_matrix(D_l);
    P_lr = build_Plr(D_l,l);
    % Construct minimal realization matrices
    A = A_0 - P_lr/P_hr*C_0;
    B = build_Qlr(N_l,l);
    C = P_hr\C_0;
end

