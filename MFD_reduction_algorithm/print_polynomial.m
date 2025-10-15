
function print_polynomial(coeffs)
% Stampa il polinomio in forma leggibile
    n = length(coeffs);
    first_term = true;
    
    for i = 1:n
        exp_order = n - i;
        coeff = coeffs(i);
        
        if coeff ~= 0
            if ~first_term
                if coeff > 0
                    fprintf(' + ');
                else
                    fprintf(' - ');
                    coeff = -coeff;
                end
            end
            
            if exp_order == 0
                fprintf('%g', coeff);
            elseif exp_order == 1
                if coeff == 1
                    fprintf('s');
                else
                    fprintf('%gs', coeff);
                end
            else
                if coeff == 1
                    fprintf('s^%d', exp_order);
                else
                    fprintf('%gs^%d', coeff, exp_order);
                end
            end
            
            first_term = false;
        end
    end
    fprintf('\n');
end