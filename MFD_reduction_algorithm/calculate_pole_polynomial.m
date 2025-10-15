function pole_poly = calculate_pole_polynomial(H)
% Calcola il polinomio dei poli di una matrice di funzione di trasferimento
% Input: H - matrice simbolica della funzione di trasferimento
% Output: pole_poly - polinomio dei poli (vettore dei coefficienti)

    % Converti in forma simbolica se necessario
    if ~isa(H, 'sym')
        H_sym = sym(H);
    else
        H_sym = H;
    end
    
    % Calcola la forma di Smith
    [~, invFact, ~] = MNsmithForm(H_sym);
    
    % Inizializza il polinomio dei poli
    pole_poly = 1;
    
    % Itera sui fattori invarianti
    for i = 1:length(invFact)
        current_inv = invFact(i);
        
        % Salta se zero, NaN o vuoto
        if isequaln(current_inv, sym(0)) || isequaln(current_inv, sym(NaN))
            continue;
        end
        
        % Separa numeratore e denominatore
        [~, den] = numden(current_inv);
        
        % Converti in polinomio e rendi monico
        den_coeffs = sym2poly(den);
        if ~isempty(den_coeffs) && den_coeffs(1) ~= 0
            den_monic = den_coeffs / den_coeffs(1);
            pole_poly = conv(pole_poly, den_monic);
        end
    end
    
    % Assicurati che sia monico
    if ~isempty(pole_poly) && pole_poly(1) ~= 0
        pole_poly = pole_poly / pole_poly(1);
    end
end