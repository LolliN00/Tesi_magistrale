function [D_l, N_l, G] = construct_row_reduced_left_MFD(H)
% CONSTRUCT_ROW_REDUCED_LEFT_MFD Constructs a row-reduced left MFD from a transfer function.
%
% INPUTS:
%   H       - Rational transfer function matrix (symbolic, in variable s)
%
% OUTPUTS:
%   D_l - Row-reduced left denominator polynomial matrix
%   N_l - Corresponding left numerator polynomial matrix
%   G   - Transfer function matrix G = D_l^(-1) * N_l (should equal H)
%
% DESCRIPTION:
%   This function constructs a row-reduced left Matrix Fraction Description (MFD)
%   from a given rational transfer function matrix H. The algorithm follows:
%   1) Clear denominators via LCM to get an initial MFD
%   2) Compute a left coprime factorization
%   3) Row-reduce the denominator
%   4) Apply the same unimodular transform to the numerator
%   5) Verify G = D_l^(-1) * N_l and compare with H
%
%   Helper functions expected:
%     - calculate_pole_polynomial
%     - calculate_lcm_and_initial_MFD
%     - calculate_left_coprime_rapresentation
%     - calculate_row_reduced_form


    if ~isa(H, 'sym')
        error('The input H must be a symbolic matrix (sym).');
    end
    fprintf('Transfer matrix H(s):\n');
    disp(H);

    % Compute the poles polynomial
    pole_poly = calculate_pole_polynomial(H);
    fprintf('Pole Polynomial P_H(s): ');
    disp(pole_poly);
    

    % Extract and print poles with automatic variable detection
    
    try
        vars = symvar(pole_poly);
        if isempty(vars)
            warning('The poles polynomial does not contain symbolic variables. Skipping root computation.');
            poles = sym([]);
        else
            % Alternatively: poles = solve(pole_poly == 0);
            poles = solve(pole_poly == 0, vars(1));
        end
        fprintf('System Poles: ');
        disp(poles.');
    catch ME
        warning('Unable to compute poles: %s', ME.message);
    end

    % Ensure full row rank
    rH = rank(H);
    if rH ~= size(H, 1)
        error('The input matrix must have full row rank (rank=%d, nrows=%d).', rH, size(H,1));
    end

    % Step 1: Initial MFD (clearing denominators via LCM)
    [N_initial, ~, D_initial] = calculate_lcm_and_initial_MFD(H);

    % Step 2: Left coprime factorization
    [D_lc, N_lc, ~] = calculate_left_coprime_rapresentation(D_initial, N_initial);

    % Step 3: Row reduction of the denominator
    [U, D_l] = calculate_row_reduced_form(D_lc);

    % Step 4: Apply the same unimodular transform to the numerator
    N_l = U * N_lc;

    % Step 5: Final verification
    G = simplify(D_l \ N_l);

    % Print D_l, N_l and G before comparison
    
    fprintf('\n=== NUMERATOR, DENOMINATOR AND RESULTING MATRIX OF MFD ===\n\n');
    fprintf('D_l(s):\n'); disp(expand(simplify(D_l)));
    fprintf('N_l(s):\n'); disp(expand(simplify(N_l)));
    fprintf('G(s) = D_l^{-1} * N_l:\n'); disp(G);

    % Compare G and H element-wise (symbolic in s) and print message if identical
    compare_symbolic_matrices(simplify(G), simplify(H));
  
end
