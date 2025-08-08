function [D_l,N_l,G] = construct_row_reduced_left_MFD(H)
[N_inital,~,D_initial] = calculate_lcm_and_initial_MFD(H);
[D_lc,N_lc,~] = calculate_left_coprime_rapresentation(D_initial,N_inital);
[U,D_l] = calculate_row_reduced_form(D_lc);
N_l = U*N_lc;
G = D_l\N_l;
end

