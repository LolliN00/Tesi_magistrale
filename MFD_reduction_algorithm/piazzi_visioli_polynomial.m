function y = piazzi_visioli_polynomial(t, tau, k)
% Transition polynomial (Piazzi-Visioli) normalized from 0 to 1,
% with saturation:
%   y(t) = 0 for t <= 0
%   y(t) = 1 for t >= tau
%   y(t) = PV polynomial for 0 < t < tau
%
% Inputs:
%   t   : scalar/vector/matrix of time values
%   tau : transition time (> 0)
%   k   : polynomial order (integer >= 0)
%
% Output:
%   y   : same size as t

    % Basic input checks
    if ~(isscalar(tau) && isreal(tau) && tau > 0)
        error('tau must be a positive real scalar.');
    end
    if ~(isscalar(k) && k == floor(k) && k >= 0)
        error('k must be an integer >= 0.');
    end

    % Initialize output and ensure numeric type
    y = zeros(size(t));
    t = double(t);

    % Masks for the three regions
    mask_pre  = (t <= 0);    % y = 0
    mask_post = (t >= tau);  % y = 1
    mask_mid  = ~(mask_pre | mask_post); % compute polynomial only on (0, tau)

    % Saturated values
    y(mask_pre)  = 0;
    y(mask_post) = 1;

    % Compute the PV polynomial only where 0 < t < tau
    if any(mask_mid(:))
        tm = t(mask_mid);

        % Normalization factor (closed form)
        norm_factor = factorial(2*k + 1) / (factorial(k)^2 * tau^(2*k + 1));

        % Unnormalized polynomial value at tm
        raw = zeros(size(tm));
        for i = 0:k
            coeff = ((-1)^(k - i)) / ( factorial(i) * factorial(k - i) * (2*k - i + 1) );
            raw = raw + coeff * tau^i .* tm.^(2*k - i + 1);
        end
        raw = norm_factor * raw;

        % Exact final value at t = tau (for robust normalization to 1)
        final_val = 0;
        for i = 0:k
            coeff = ((-1)^(k - i)) / ( factorial(i) * factorial(k - i) * (2*k - i + 1) );
            final_val = final_val + coeff * tau^i * tau^(2*k - i + 1);
        end
        final_val = norm_factor * final_val;

        % Normalize to ensure y(tau) = 1
        y(mask_mid) = raw ./ final_val;
    end
end