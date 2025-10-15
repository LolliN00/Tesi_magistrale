function [Q0, P1] = right_divide_polymat(P, Q, s)
%RIGHT_DIVIDE_POLYMAT Perform matrix right-division:
%   Find Q0(s), P1(s) such that P(s) = Q(s)*Q0(s) + P1(s)
%   with deg_col(P1) < deg_col(Q) (after equalization).
%
% Inputs:
%   P, Q : symbolic m×m polynomial matrices in variable s
%   s    : symbolic variable
%
% Outputs:
%   Q0   : symbolic m×m polynomial matrix (quotient)
%   P1   : symbolic m×m polynomial matrix (remainder)
%
% Notes:
% - Q is assumed row-reduced (left MFD) so that the leading coefficient
%   matrix at the (equalized) column degree is nonsingular.
% - The algorithm equalizes column degrees of Q to a common dmax via
%   S(s) = diag(s^(dmax - dQ_j)), works on Qtilde = Q*S, then maps back:
%   Q0 = S * Q0_tilde.

    % sizes
    [m,n] = size(P);
    assert(m == n, 'P must be square');
    assert(isequal(size(Q), [m,m]), 'Q must be same size as P');

    % Compute column degrees of Q and equalize to dmax
    dQ = zeros(1,m);
    for j = 1:m
        dQ(j) = col_degree(Q(:,j), s);
        assert(dQ(j) >= 0, 'Column %d of Q has no polynomial degree (all zeros?)', j);
    end
    dmax = max(dQ);

    % Equalization diagonal: S = diag(s^(dmax - dQ(j)))
    S = sym(zeros(m));
    for j = 1:m
        S(j,j) = s^(dmax - dQ(j));
    end

    % Equalized Q tilde
    Qtilde = expand(Q * S);

    % Leading coefficient matrix L at degree dmax of Qtilde
    L = sym(zeros(m));
    for j = 1:m
        L(:,j) = coeff_vec_at_degree(Qtilde(:,j), s, dmax);
    end
    % Must be invertible for a proper row-reduced MFD
    if det(L) == 0
        warning('Leading coefficient matrix L is singular. Division may fail or be non-unique.');
    end

    % Initialize outputs
    Q0  = sym(zeros(m));
    P1  = sym(zeros(m));

    % Process each column of P: P(:,j) = Qtilde * qtilde_j + r_j
    for j = 1:m
        rj = expand(P(:,j));                  % current residual column
        qtilde_j = sym(zeros(m,1));          % quotient column in tilde space

        % Long division per column using equalized degree dmax
        deg_rj = col_degree(rj, s);
        while deg_rj >= dmax
            % Leading coefficient of rj at degree deg_rj
            ck = coeff_vec_at_degree(rj, s, deg_rj);

            % Solve L * a = ck for the current leading match
            % (symbolic solve; prefer linsolve/ backslash)
            a = L \ ck;  % vector of constants (symbolic)

            % Update quotient: add a * s^(deg_rj - dmax)
            power = deg_rj - dmax;
            qtilde_j = expand(qtilde_j + a * s^power);

            % Subtract matched leading term: rj <- rj - Qtilde * (a * s^power)
            rj = expand(rj - Qtilde * (a * s^power));

            % Update residual degree
            deg_rj = col_degree(rj, s);
        end

        % Map back from tilde space: Q0(:,j) = S * qtilde_j
        Q0(:,j) = expand(S * qtilde_j);

        % Remainder column
        P1(:,j) = expand(rj);
    end

    % Optional final simplification
    Q0 = simplify(Q0);
    P1 = simplify(P1);
end

% ===== Helper: column degree (max degree among entries of a column vector) =====
function d = col_degree(col, s)
    d = -inf;
    for i = 1:numel(col)
        [~, p] = coeffs(expand(col(i)), s);
        if ~isempty(p)
            d = max(d, double(max(p)));  % p are symbolic exponents
        end
    end
    if isinf(d)
        d = -1;  % pure zero column
    end
end

% ===== Helper: coefficient vector at a given degree k =====
function ck = coeff_vec_at_degree(col, s, k)
    m = numel(col);
    ck = sym(zeros(m,1));
    for i = 1:m
        poly_ij = expand(col(i));
        [cc, pp] = coeffs(poly_ij, s);
        idx = find(double(pp) == k, 1);
        if isempty(idx)
            ck(i) = sym(0);
        else
            ck(i) = cc(idx);
        end
    end
end