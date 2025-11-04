function y = piazzi_visioli_polynomial(t, tau, k)
% Symbolic definition of the normalized Piazzi-Visioli transition:
% Inputs:
%   t   : symbolic variable (time)
%   tau : symbolic positive scalar
%   k   : symbolic or numeric integer >= 0
%
% Output:
%   y   : symbolic expression in t
    t   = sym(t);
    tau = sym(tau);
    k   = sym(k);
    i = sym('i', 'integer');
    norm_factor = factorial(2*k + 1) / (factorial(k) * tau^(2*k + 1));
    term_i = ((-1)^(k - i)) / ( factorial(i) * factorial(k - i) * (2*k - i + 1) ) ...
             * tau^i * t^(2*k - i + 1);
    y = norm_factor * symsum(term_i, i, 0, k);
    %y = piecewise(t <= 0, 0, t >= tau, 1, y_mid);
end