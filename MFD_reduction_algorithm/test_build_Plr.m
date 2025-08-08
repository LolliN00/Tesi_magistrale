% Test script for build_Plr function
clear; clc;
syms s;

% Define P(s) as given in the example
P = [-s^2 - s, s^2 + 2*s + 1;
     -2*s - 2,     s + 1];

disp('P(s) = ');
disp(P);

% Calculate degrees for each row
l1 = 2; % first row has degree 2
l2 = 1; % second row has degree 1
l = [l1, l2];

disp(['Row degrees l = [', num2str(l1), ', ', num2str(l2), ']']);

% Calculate P_hr (high-degree coefficients)
% For row 1 (degree 2): coefficients of s^2
P_hr = sym(zeros(2, 2));
P_hr(1, 1) = -1; % coefficient of s^2 in -s^2-s
P_hr(1, 2) = 1;  % coefficient of s^2 in s^2+2s+1
P_hr(2, 1) = -2; % coefficient of s^1 in -2s-2  
P_hr(2, 2) = 1;  % coefficient of s^1 in s+1

disp('P_hr = ');
disp(P_hr);

% Calculate D_l (diagonal matrix with s^l_i)
D_l = diag([s^l1, s^l2]);
disp('D_l = ');
disp(D_l);

% Calculate residue matrix R = P(s) - D_l * P_hr
R = P - D_l * P_hr;
R = simplify(R);

disp('Residue matrix R = ');
disp(R);

% Test build_Plr function
P_lr = build_Plr(D_l, R, l);

disp('P_lr calculated by build_Plr:');
disp(P_lr);

% Expected P_lr based on manual calculation:
% Row 1, degree 1: [-1, 2] (coefficients of s)
% Row 1, degree 0: [0, 1]  (constant terms)
% Row 2, degree 0: [-2, 1] (constant terms)
P_lr_expected = [-1, 2;
                  0, 1;
                 -2, 1];

disp('Expected P_lr:');
disp(P_lr_expected);

% Compare results
disp('Comparison (difference should be zero):');
disp(simplify(P_lr - P_lr_expected));