function [A,B,C] = calculate_minimal_realization(D_l,N_l)
l = calculate_row_deg_vector(D_l);
A_0 = build_A0(l);
C_0 = build_C0(l);
P_hr = calculate_leading_row_matrix(D_l);
P_lr = build_Plr(D_l,l);
A = A_0 - P_lr/P_hr*C_0;
B = build_Qlr(N_l,l);
C = P_hr\C_0;
end

