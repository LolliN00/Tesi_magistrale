function l = calculate_row_deg_vector(D_l)
    l = zeros(1,size(D_l,1));
    for i = 1:size(D_l,1)
    l(i) = calculate_vector_degree(D_l(i,:));
    end
end

