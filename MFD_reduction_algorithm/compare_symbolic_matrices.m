

function compare_symbolic_matrices(A, B)
% COMPARE_SYMBOLIC_MATRICES Compares two symbolic matrices element by element
%
% INPUTS:
%   A - First symbolic matrix
%   B - Second symbolic matrix  
%
% DESCRIPTION:
%   This function compares two symbolic matrices element by element.
%   If all corresponding elements are equal (after simplification),
%   it prints "The two matrices are equal!"
%
    % Check if both inputs are symbolic
    if ~isa(A, 'sym') || ~isa(B, 'sym')
        error('Both inputs must be symbolic matrices.');
    end
    
    % Get dimensions
    [m1, n1] = size(A);
    [m2, n2] = size(B);
    
    % Check if dimensions match
    if m1 ~= m2 || n1 ~= n2
        fprintf('The matrices have different dimensions: A is %dx%d, B is %dx%d\n', ...
                m1, n1, m2, n2);
        fprintf('The two matrices are NOT equal!\n');
        return;
    end
    
    % Element-wise comparison
    are_equal = true;
    different_elements = [];
    
    fprintf('Comparing matrices element by element...\n');
    
    for i = 1:m1
        for j = 1:n1
            % Simplify the difference to check equality
            diff = simplify(A(i,j) - B(i,j));
            
            % Check if the difference is zero
            if ~isequal(diff, sym(0))
                are_equal = false;
                different_elements = [different_elements; i, j];
                fprintf('  Element (%d,%d): NOT equal\n', i, j);
                fprintf('    A(%d,%d) = %s\n', i, j, char(A(i,j)));
                fprintf('    B(%d,%d) = %s\n', i, j, char(B(i,j)));
            end
        end
    end
    
    % Print final result
    if are_equal
        fprintf('\nThe two matrices are equal!\n');
    else
        fprintf('\nThe two matrices are NOT equal!\n');
        fprintf('Found %d different element(s) at positions:\n', size(different_elements, 1));
        for k = 1:size(different_elements, 1)
            fprintf('  (%d, %d)\n', different_elements(k, 1), different_elements(k, 2));
        end
    end
    
end