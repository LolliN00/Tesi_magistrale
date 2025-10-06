function y = piazzi_visioli_polynomial(t, tau, k)
    % Funzione di transizione normalizzata (0 -> 1)

    % Variabile simbolica temporanea
    syms tsym;

    % Fattore di normalizzazione
    norm_factor = factorial(2*k+1) / (factorial(k)^2 * tau^(2*k+1));

    % Costruzione della somma simbolica
    s = 0;
    for i = 0:k
        coeff = ((-1)^(k-i)) / ( factorial(i) * factorial(k-i) * (2*k - i + 1) );
        s = s + coeff * tau^i * tsym^(2*k - i + 1);
    end
    raw_sym = norm_factor * s;

    % Valore finale a t = tau
    final_val = double(subs(raw_sym, tsym, tau));

    % Adesso calcolo per i valori numerici di t
    raw = 0;
    for i = 0:k
        coeff = ((-1)^(k-i)) / ( factorial(i) * factorial(k-i) * (2*k - i + 1) );
        raw = raw + coeff * tau^i .* t.^(2*k - i + 1);
    end
    raw = norm_factor * raw;

    % Normalizzazione
    y = raw ./ final_val;
end
