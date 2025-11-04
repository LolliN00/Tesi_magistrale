function Q_lr = build_Qlr(Q, l)
% BUILD_QLR Constructs the Q_lr coefficient matrix from polynomial matrix Q.
%
% INPUTS:
%   Q - Polynomial matrix of size p×m (symbolic)
%   l - Vector of row degrees [l1, l2, ..., lp] where li is the degree of row i
%
% OUTPUT:
%   Q_lr - Coefficient matrix of size (sum(l) x m) such that Q(s) = Gamma(s)*Q_lr,
%          where Gamma is constructed from the degree vector l
%
% DESCRIPTION:
%   This function extracts polynomial coefficients from matrix Q to create Q_lr
%   such that the relationship Q(s) = Gamma(s)*Q_lr holds, where Gamma is built
%   from the row degrees in vector l. For each row i of Q, it extracts coefficients
%   for polynomial degrees (li-1) down to 0, organizing them sequentially in Q_lr.

    syms s
    [p, m] = size(Q);
    assert(numel(l)==p, 'Vector l must have p elements (one for each row of Q).')

    Rtot = sum(l);
    Q_lr = sym(zeros(Rtot, m));

    r = 1;
    for i = 1:p
        % Extract coefficients from row i for degrees li-1, li-2, ..., 0
        for deg = l(i)-1 : -1 : 0
            for j = 1:m
                % Extract coefficient of s^deg from Q(i,j)
                Q_lr(r, j) = feval(symengine, 'coeff', Q(i,j), s, deg);
            end
            r = r + 1;
        end
    end
end
