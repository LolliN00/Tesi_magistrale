function out = D_operator(Ms, f, t, s)
% Applica l'operatore polinomiale Ms(s) sostituendo s -> D (d/dt)
% Ms: matrice simbolica m×n polinomiale in s
% f : vettore simbolico n×1 di funzioni del tempo t
% t,s: simboli (passati dal chiamante)

    Ms = sym(Ms);
    f  = sym(f);
    [m,n] = size(Ms);
    f = reshape(f, [n,1]);

    out = sym(zeros(m,1));

    for i = 1:m
        acc = sym(0);
        for j = 1:n
            Mij = expand(Ms(i,j));
            % c: coefficienti; terms: monomi (1, s, s^2, ...)
            [c, terms] = coeffs(Mij, s);
            term = sym(0);
            for k = 1:numel(c)
                % Grado del monomio terms(k) in s (0 per costante, 1 per s, ecc.)
                degk = feval(symengine, 'degree', terms(k), s);
                % Alcune versioni possono dare -Inf per 0; qui non dovrebbe accadere
                if isequal(degk, sym(-inf))
                    degk = sym(0);
                end
                term = term + c(k) * diff(f(j), t, double(degk));
            end
            acc = acc + term;
        end
        out(i) = simplify(acc);
    end
end