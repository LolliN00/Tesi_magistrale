function [A, B, C, D_l, N_l] = mfd_reduction(H)
% MFD_REDUCTION Complete MFD reduction and minimal realization workflow.
%
% INPUTS:
%   H - Rational transfer function matrix (symbolic)
%
% OUTPUTS:
%   A, B, C - Minimal state-space realization matrices
%   D_l     - Row-reduced left denominator matrix
%   N_l     - Corresponding left numerator matrix
%
% DESCRIPTION:
%   This is the main function that performs the complete MFD reduction workflow:
%   1. Constructs row-reduced left MFD from transfer function H
%   2. Computes minimal state-space realization (A,B,C)
%   3. Returns both the MFD representation and state-space form
%
% EXAMPLE:
%   syms s
%   H = [1/(s+1), s/(s^2+2*s+1); 2/(s+2), 1/(s+3)];
%   [A, B, C, D_l, N_l] = mfd_reduction(H);
%
% See also: CONSTRUCT_ROW_REDUCED_LEFT_MFD, CALCULATE_MINIMAL_REALIZATION

    % Step 1: Construct row-reduced left MFD
    [D_l, N_l, ~] = construct_row_reduced_left_MFD(H);
    
    % Step 2: Calculate minimal realization
    [A, B, C] = calculate_minimal_realization(D_l, N_l);
    
    % Display summary
    fprintf('\n=== MFD REDUCTION SUMMARY ===\n');
    fprintf('Original transfer function: %dx%d\n', size(H,1), size(H,2));
    fprintf('Minimal realization dimension: %d\n', size(A,1));
    fprintf('Row degrees: [%s]\n', num2str(calculate_row_deg_vector(D_l)));
    fprintf('=============================\n\n');
end