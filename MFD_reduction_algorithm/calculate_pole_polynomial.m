function P_s = calculate_pole_polynomial(H)
% CALCULATE_POLE_POLYNOMIAL Computes the pole polynomial of a transfer matrix.
%
% SYNTAX:
%   P_s = calculate_pole_polynomial(H)
%
% INPUT:
%   H - Transfer matrix (symbolic rational functions in s)
%       Each element H(i,j) is a rational function of the form N(s)/D(s)
%
% OUTPUT:
%   P_s - Monic pole polynomial (polynomial with leading coefficient = 1)
%         Contains all system poles as roots
%
% DESCRIPTION:
%   This function computes the pole polynomial as the least common multiple
%   (LCM) of all denominators of non-zero minors of H(s). The process includes:
%   1. Computing all possible minors of matrix H
%   2. Extracting denominators from each non-zero minor
%   3. Computing the LCM of all denominators
%   4. Normalizing to obtain a monic polynomial
%
% ALGORITHM:
%   - For each order k from 1 to min(m,n), computes all k×k minors
%   - Extracts the denominator of each non-zero minor
%   - Computes the LCM of all found denominators
%   - Normalizes the result to make it monic
%
% NOTE:
%   If the matrix is polynomial (no denominators), returns P_s = 1

    syms s

    % Get matrix dimensions (m = rows, n = columns)
    [m, n] = size(H);

    % Simplify all matrix elements for better numerical stability
    % This reduces computational complexity in subsequent operations
    H_simplified = simplify(H);

    % Initialize array to store all non-zero minors
    all_minors = [];

    % Maximum minor order is limited by the smaller dimension
    max_order = min(m, n);

    % Loop through all possible minor orders (1×1, 2×2, ..., max_order×max_order)
    for order = 1:max_order
        if order == 1
            % First order minors are simply the matrix elements
            for i = 1:m
                for j = 1:n
                    if H_simplified(i,j) ~= 0
                        all_minors = [all_minors, H_simplified(i,j)];
                    end
                end
            end
        else
            % Higher order minors: compute determinants of all possible submatrices
            % Generate all combinations of rows and columns for this order
            row_combs = nchoosek(1:m, order);
            col_combs = nchoosek(1:n, order);

            % Calculate determinant for each possible submatrix combination
            for r = 1:size(row_combs, 1)
                for c = 1:size(col_combs, 1)
                    % Extract submatrix using selected rows and columns
                    submatrix = H_simplified(row_combs(r,:), col_combs(c,:));
                    % Compute determinant (the minor)
                    minor = det(submatrix);
                    minor = simplify(minor);
                    % Store only non-zero minors
                    if minor ~= 0
                        all_minors = [all_minors, minor];
                    end
                end
            end
        end
    end

    % If no non-zero minors found, matrix is zero → pole polynomial is 1
    if isempty(all_minors)
        P_s = sym(1);
        return;
    end

    % Extract denominators from all minors for LCM computation
    denominators = [];
    for i = 1:length(all_minors)
        % Separate numerator and denominator of each minor
        [~, den] = numden(all_minors(i));
        % Collect only non-trivial denominators (not equal to 1)
        if den ~= 1
            denominators = [denominators, den];
        end
    end

    % If no denominators found, matrix is polynomial → pole polynomial is 1
    if isempty(denominators)
        P_s = sym(1);
        return;
    end

    % Compute the least common multiple (LCM) of all denominators
    % This gives us the pole polynomial containing all system poles
    P_s = denominators(1);
    for i = 2:length(denominators)
        P_s = lcm(P_s, denominators(i));
    end

    % Simplify the resulting polynomial
    P_s = simplify(P_s);

    % Normalize to make the polynomial monic (leading coefficient = 1)
    % This is the standard form for pole polynomials
    if P_s ~= 0 && P_s ~= 1
        % Find the degree of the polynomial
        degree = feval(symengine, 'degree', P_s);
        if degree > 0
            % Extract the leading coefficient (coefficient of highest degree term)
            leading_coeff = feval(symengine, 'coeff', P_s, s, degree);
            % Divide by leading coefficient to make it monic
            if leading_coeff ~= 0 && leading_coeff ~= 1
                P_s = P_s / leading_coeff;
                P_s = simplify(P_s);
                P_s = expand(P_s);
            end
        end
    end

end