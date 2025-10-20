
clear; clc; close all;

%% 1. Parametri
tau_val = 2;     
y10_val = 2;        
y20_val = -3;       
disp('Conversione v(t) a funzioni numeriche...');
% Per t in [0, tau]
v1_mfd_func = matlabFunction(v_mfd(1), 'Vars', {t});
v2_mfd_func = matlabFunction(v_mfd(2), 'Vars', {t});

% Per t > tau
v1_after_func = matlabFunction(v_mfd_after_tau(1), 'Vars', {t});
v2_after_func = matlabFunction(v_mfd_after_tau(2), 'Vars', {t});

% Uscite desiderate
y1_func = matlabFunction(y1, 'Vars', {t});
y2_func = matlabFunction(y2, 'Vars', {t});
%% 4. Genera vettori temporali
t_start = 0;       
t_end = tau_val + 3;   
dt = 0.001;            
t_vec = (t_start:dt:t_end)';
N = length(t_vec);
disp(['Generazione ', num2str(N), ' campioni...']);

%% 5. Calcola v(t) per ogni istante
v1_data = zeros(N, 1);
v2_data = zeros(N, 1);

for i = 1:N
    t_i = t_vec(i);
    
    if t_i < 0
        % Prima di t=0: ingresso nullo
        v1_data(i) = 0;
        v2_data(i) = 0;
        
    elseif t_i <= tau_val
        % Transizione [0, tau]
        v1_data(i) = v1_mfd_func(t_i);
        v2_data(i) = v2_mfd_func(t_i);
        
    else
        % Regime permanente t > tau
        v1_data(i) = v1_after_func(t_i);
        v2_data(i) = v2_after_func(t_i);
    end
end

%% 6. Calcola uscite desiderate

y1_data = zeros(N, 1);
y2_data = zeros(N, 1);

for i = 1:N
    t_i = t_vec(i);
    
    if t_i < 0
        y1_data(i) = 0;
        y2_data(i) = 0;
    elseif t_i <= tau_val
        y1_data(i) = y1_func(t_i);
        y2_data(i) = y2_func(t_i);
    else
        y1_data(i) = y10_val;
        y2_data(i) = y20_val;
    end
end

%% 7. Crea timeseries per Simulink

v1_ts = timeseries(v1_data, t_vec);
v1_ts.Name = 'v1_input';

v2_ts = timeseries(v2_data, t_vec);
v2_ts.Name = 'v2_input';

y1_des_ts = timeseries(y1_data, t_vec);
y1_des_ts.Name = 'y1_desired';

y2_des_ts = timeseries(y2_data, t_vec);
y2_des_ts.Name = 'y2_desired';

%% 8. Crea modello State-Space del sistema


% Dimensioni
n_states = size(A, 1);
n_inputs = size(B, 2);
n_outputs = size(C, 1);

fprintf('Sistema: %d stati, %d ingressi, %d uscite\n', ...
        n_states, n_inputs, n_outputs);

%% 9. Salva tutto

save('quadtank_simulink_data.mat', ...
     'v1_ts', 'v2_ts', 'y1_des_ts', 'y2_des_ts', ...
     't_vec', 'v1_data', 'v2_data', 'y1_data', 'y2_data', ...
     'A', 'B', 'C', 'D', ...
     'tau_val', 'y10_val', 'y20_val', 't_start', 't_end', 'dt');

disp(' ');
disp('✓ Dati salvati in: quadtank_simulink_data.mat');

%% 10. Preview grafici

figure('Position', [100, 100, 1400, 900]);

subplot(3,2,1);
plot(t_vec, v1_data, 'b', 'LineWidth', 2);
grid on; xlabel('Time [s]'); ylabel('v_1 [V]');
title('Ingresso Pompa 1');
xline(0, 'k--', 'LineWidth', 1.5);
xline(tau_val, 'k--', 'LineWidth', 1.5);
xlim([t_start, t_end]);

subplot(3,2,2);
plot(t_vec, v2_data, 'r', 'LineWidth', 2);
grid on; xlabel('Time [s]'); ylabel('v_2 [V]');
title('Ingresso Pompa 2');
xline(0, 'k--', 'LineWidth', 1.5);
xline(tau_val, 'k--', 'LineWidth', 1.5);
xlim([t_start, t_end]);

subplot(3,2,3);
plot(t_vec, y1_data, 'b', 'LineWidth', 2);
grid on; xlabel('Time [s]'); ylabel('h_1 [cm]');
title('Uscita Desiderata 1');
xline(0, 'k--', 'LineWidth', 1.5);
xline(tau_val, 'k--', 'LineWidth', 1.5);
xlim([t_start, t_end]);

subplot(3,2,4);
plot(t_vec, y2_data, 'r', 'LineWidth', 2);
grid on; xlabel('Time [s]'); ylabel('h_2 [cm]');
title('Uscita Desiderata 2');
xline(0, 'k--', 'LineWidth', 1.5);
xline(tau_val, 'k--', 'LineWidth', 1.5);
xlim([t_start, t_end]);

subplot(3,2,5);
plot(t_vec, v1_data, 'b', t_vec, v2_data, 'r', 'LineWidth', 2);
legend('v_1', 'v_2', 'Location', 'best');
grid on; xlabel('Time [s]'); ylabel('Voltage [V]');
title('Ingressi Combinati');
xline(0, 'k--'); xline(tau_val, 'k--');

subplot(3,2,6);
plot(t_vec, y1_data, 'b', t_vec, y2_data, 'r', 'LineWidth', 2);
legend('y_1', 'y_2', 'Location', 'best');
grid on; xlabel('Time [s]'); ylabel('Level [cm]');
title('Uscite Desiderate Combinate');
xline(0, 'k--'); xline(tau_val, 'k--');
sgtitle('Preview Segnali per Simulink', 'FontSize', 14, 'FontWeight', 'bold');