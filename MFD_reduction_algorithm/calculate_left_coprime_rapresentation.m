function [U,herm,D_cop,N_cop] = calculate_left_coprime_rapresentation(D_r,N_r)
    syms s;
    m = size(D_r,1);
    p = size(N_r,1);
    impiled_matrix = [D_r;N_r];
    [U,herm] = hermiteForm(impiled_matrix);
    U_21 = U(end-p+1:end, 1:m);
    U_22 = U(end-p+1:end, end-p+1:end);
    D_cop = -U_22;
    N_cop = U_21;



end

