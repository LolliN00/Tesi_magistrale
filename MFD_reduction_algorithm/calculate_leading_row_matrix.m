function M_rr = calculate_leading_row_matrix(M)
M_cr = calculate_leading_col_matrix(M.');
M_rr = M_cr';
end
