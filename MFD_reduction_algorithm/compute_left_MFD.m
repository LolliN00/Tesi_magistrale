function [M] = compute_left_MFD(D_l,N_l)

M = inv(D_l)\N_l;
end

