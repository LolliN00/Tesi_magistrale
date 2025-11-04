function [M] = compute_left_MFD(D_l,N_l)
% COMPUTE_LEFT_MFD Computes the transfer function matrix from left MFD.
%
% INPUTS:
%   D_l - Left denominator polynomial matrix (symbolic)
%   N_l - Left numerator polynomial matrix (symbolic)
%
% OUTPUT:
%   M - Transfer function matrix computed as M(s) = D_l^(-1) * N_l
%
% DESCRIPTION:
%   This function computes the transfer function matrix M from a left Matrix
%   Fraction Description (MFD) representation. Given the left coprime polynomial
%   matrices D_l and N_l, it calculates M = D_l^(-1) * N_l, which represents
%   the original rational transfer function matrix in standard form.

    % Compute transfer function as D_l^(-1) * N_l
    M = inv(D_l)\N_l;
end

