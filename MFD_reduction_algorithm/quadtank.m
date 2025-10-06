syms s;
G_minus = [2.6/(1+62*s), 1.5/((1+23*s)*(1+62*s));1.4/((1+30*s)*(1+90*s)),2.8/(1+90*s)];
[D_l, N_l, ~] = construct_row_reduced_left_MFD(G_minus);

% Compute G^-1(s) = Q0(s) + H0(s)
% where Q0(s) is the polynomial part and H0(s) is the strictly proper part
% Compute inverse of G_minus
G_inv = simplify(inv(G_minus));

% Preallocate symbolic matrices for polynomial part (Q0) and strictly proper part (H0)
[rows, cols] = size(G_inv);
Q0 = sym(zeros(rows, cols));
H0 = sym(zeros(rows, cols));

% Loop through each entry of G_inv and perform polynomial division
for ii = 1:rows
    for jj = 1:cols
        % Extract numerator and denominator of the (ii,jj)-th entry
        [num, den] = numden(G_inv(ii,jj));

        % Polynomial division: num/den = q_poly + r_poly/den
        [q_poly, r_poly] = quorem(num, den, s);

        % Store results
        Q0(ii,jj) = q_poly;       % Polynomial part
        H0(ii,jj) = r_poly/den;   % Strictly proper (remainder) part
    end
end

% Simplify results
Q0 = simplify(Q0);
H0 = simplify(H0);

% Check decomposition: G_inv = Q0 + H0
verification = simplify(G_inv - (Q0 + H0));

disp('=== DECOMPOSITION G^-1(s) = Q0(s) + H0(s) ===');
disp(' ');
disp('Q0(s) - Polynomial part:');
disp(Q0);
disp(' ');
disp('H0(s) - Strictly proper part:');
disp(H0);
disp(' ');
disp('Verification Q0 + H0 - G^-1 (must be zero):');
disp(verification);

%% Input-Output Inversion for Minimum-Phase System G-(s)

% Define desired deviations from operating point
% Tank 1: from 12.4 cm to 14.4 cm => Delta_h1 = +2.0 cm
% Tank 2: from 12.7 cm to 9.7 cm  => Delta_h2 = -3.0 cm
Delta_h = [2.0; -3.0]; % cm (deviations)

% Transition time and polynomial order
tau = 10; % seconds (transition duration)
k = 3;    % polynomial order (ensures C^(k-1) continuity)

% Time vector
dt = 0.01;
t = 0:dt:tau;

% Piazzi-Visioli transition polynomial (equation 11)
% sigma(t,tau,k) = sum_{i=0}^{k-1} c_i * (t/tau)^(k+i)
% where c_i = (-1)^i * binom(k-1+i, i) * binom(k, i+1)


% Calculate desired trajectory yd(t) for each output
yd1 = Delta_h(1) * piazzi_visioli_polynomial(t, tau, k);
yd2 = Delta_h(2) * piazzi_visioli_polynomial(t, tau, k);
yd = [yd1; yd2];

% Verification plots
disp(' ');
disp('=== DESIRED TRAJECTORY yd(t) ===');
disp(['Transition time tau = ', num2str(tau), ' s']);
disp(['Polynomial order k = ', num2str(k)]);
disp(['Delta_h1 = ', num2str(Delta_h(1)), ' cm']);
disp(['Delta_h2 = ', num2str(Delta_h(2)), ' cm']);
disp(' ');
disp('Verification at t=0:');
disp(['yd1(0) = ', num2str(yd1(1)), ' cm (should be 0)']);
disp(['yd2(0) = ', num2str(yd2(1)), ' cm (should be 0)']);
disp(' ');
disp(['Verification at t=tau=', num2str(tau), ':']);
disp(['yd1(tau) = ', num2str(yd1(end)), ' cm (should be ', num2str(Delta_h(1)), ')']);
disp(['yd2(tau) = ', num2str(yd2(end)), ' cm (should be ', num2str(Delta_h(2)), ')']);

figure;
subplot(2,1,1);
plot(t, yd1, 'LineWidth', 2);
grid on;
xlabel('Time [s]');
ylabel('y_{d,1}(t) [cm]');
title('Desired Trajectory - Tank 1 (Deviation from Operating Point)');

subplot(2,1,2);
plot(t, yd2, 'LineWidth', 2);
grid on;
xlabel('Time [s]');
ylabel('y_{d,2}(t) [cm]');
title('Desired Trajectory - Tank 2 (Deviation from Operating Point)');