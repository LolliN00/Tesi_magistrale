function pole_poly = calculate_pole_polynomial(H)
% CALCULATE_POLE_POLYNOMIAL Computes the pole polynomial of a transfer function matrix.
%
% INPUTS:
%   H - Symbolic transfer function matrix
%
% OUTPUT:
%   pole_poly - Pole polynomial (coefficient vector, monic form)
%
% DESCRIPTION:
%   This function computes the pole polynomial of a transfer function matrix H
%   by calculating the Smith normal form and extracting the least common multiple
%   of all denominators from the invariant factors. The result is returned as a
%   monic polynomial (leading coefficient = 1).

    % Convert to symbolic form if necessary
    if ~isa(H, 'sym')
        H_sym = sym(H);
    else
        H_sym = H;
    end

    % Compute Smith normal form
    [~, invFact, ~] = MNsmithForm(H_sym);

    % Initialize pole polynomial
    pole_poly = 1;

    % Iterate over invariant factors
    for i = 1:length(invFact)
        current_inv = invFact(i);

        % Skip if zero, NaN or empty
        if isequaln(current_inv, sym(0)) || isequaln(current_inv, sym(NaN))
            continue;
        end

        % Separate numerator and denominator
        [~, den] = numden(current_inv);

        % Convert to polynomial and make monic
        den_coeffs = sym2poly(den);
        if ~isempty(den_coeffs) && den_coeffs(1) ~= 0
            den_monic = den_coeffs / den_coeffs(1);
            pole_poly = conv(pole_poly, den_monic);
        end
    end

    % Ensure the result is monic
    if ~isempty(pole_poly) && pole_poly(1) ~= 0
        pole_poly = pole_poly / pole_poly(1);
    end
end