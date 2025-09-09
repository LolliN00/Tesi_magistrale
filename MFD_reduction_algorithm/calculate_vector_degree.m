function deg_max = calculate_vector_degree(vector)
% CALCULATE_VECTOR_DEGREE Computes the maximum degree of polynomials in a vector.
%
% INPUTS:
%   vector - Vector of symbolic polynomials
%
% OUTPUT:
%   deg_max - Maximum degree among all polynomials in the vector
%             Returns -1 if all polynomials are zero or vector is empty
%
% DESCRIPTION:
%   This function finds the highest polynomial degree among all entries in the
%   input vector. Each entry is treated as a symbolic polynomial, and its degree
%   is computed using the symengine 'degree' function. The maximum degree found
%   is returned, which is useful for determining row/column degrees in polynomial
%   matrix operations.

    deg_max = -1;  

    % Handle empty vector case
    if isempty(vector)
        return;
    end

    % Ensure vector is a row vector
    vector = vector(:).';

    % Find maximum degree among all vector elements
    for i = 1:length(vector)
        p = vector(i);  
        % Get degree of polynomial p using symbolic engine
        deg = feval(symengine, 'degree', p);  

        % Update maximum degree if current degree is higher
        if deg > deg_max
            deg_max = deg;
        end
    end
end
