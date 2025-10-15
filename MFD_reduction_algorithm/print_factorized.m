function print_factorized(coeffs)
% Stampa la forma fattorizzata del polinomio
    s = sym('s');
    poly_sym = poly2sym(coeffs, s);
    factored = factor(poly_sym);
    
    if isa(factored, 'sym')
        disp(factored);
    else
        % Se factor restituisce un array di fattori
        for i = 1:length(factored)
            if i > 1
                fprintf(' * ');
            end
            fprintf('%s', char(factored(i)));
        end
        fprintf('\n');
    end
end