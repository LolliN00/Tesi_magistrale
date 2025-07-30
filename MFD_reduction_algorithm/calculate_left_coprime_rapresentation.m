function [D_cop, N_cop,G] = calculate_left_coprime_rapresentation(D_r, N_r)
% Calculates a left coprime factorization (D_cop^-1 * N_cop)
% from a given right coprime factorization (N_r * D_r^-1).

    % Define the symbolic variable for polynomials.
    syms s;

    % Get dimensions of the input matrices: D_r is m x m, N_r is p x m.
    m = size(D_r, 1);
    p = size(N_r, 1);

    % Create the stacked matrix from the right factorization components.
    impiled_matrix = [D_r; N_r];

    % Compute the Hermite normal form of the stacked matrix.
    % 'U' is the unimodular transformation matrix such that U*[D_r; N_r] = herm.
    [U, ~] = hermiteForm(impiled_matrix);

    % From the bottom block-row of the equation U * [D_r; N_r] = [H; 0],
    % we get the Bezout identity: U21*D_r + U22*N_r = 0.
    % This implies N_r*D_r^-1 = -inv(U22)*U21, which defines the left factorization.
    
    % Extract the bottom-left p-by-m block (U21) from the unimodular matrix U.
    U_21 = U(end-p+1:end, 1:m);
    
    % Extract the bottom-right p-by-p block (U22) from the unimodular matrix U.
    U_22 = U(end-p+1:end, end-p+1:end);

    % The left coprime factors are derived from the blocks U21 and U22.
    D_cop = -U_22;
    N_cop = U_21;
    G = D_cop\N_cop;
end