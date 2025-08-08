function deg_max = calculate_vector_degree(vector)
    deg_max = -1;  

   
    if isempty(vector)
        return;
    end

   
    vector = vector(:).';

    for i = 1:length(vector)
        p = vector(i);  
        deg = feval(symengine, 'degree', p);  

       
        if deg > deg_max
            deg_max = deg;
        end
    end
end
