% =========================================================
%  SCRIPT 4: Parametric Study
%  Subject:  All three — this is the "extra mile" script
%
%  Study A: How does minimum safety factor change with wall thickness?
%  Study B: How does heat flux change with wall thickness?
%  Study C: Pressure vs SF — what is the maximum safe pressure?
% =========================================================

clc; clear; close all;

fprintf('==============================================\n');
fprintf('  SCRIPT 4: Parametric Study\n');
fprintf('==============================================\n\n');

% ---------- Fixed Parameters ----------
r_i     = 0.10;         % Inner radius (m)  — fixed
p_i     = 10e6;         % Internal pressure (Pa)
sigma_y = 250e6;        % Yield strength (Pa)
k       = 50;           % Thermal conductivity (W/m·K)
T_i     = 300;          % Inner temperature (°C)
T_o     = 50;           % Outer temperature (°C)
L       = 1;            % Unit length (m)
SF_req  = 2.0;          % Required safety factor

% ============================================================
%  STUDY A: Wall Thickness vs Minimum Safety Factor
% ============================================================
thickness_range = linspace(0.01, 0.10, 80);   % 10 mm to 100 mm
SF_min_arr      = zeros(size(thickness_range));
Q_arr           = zeros(size(thickness_range));

for i = 1:length(thickness_range)
    t   = thickness_range(i);
    r_o = r_i + t;
    r   = linspace(r_i, r_o, 200);

    % Lamé
    A = p_i * r_i^2 / (r_o^2 - r_i^2);
    B = p_i * r_i^2 * r_o^2 / (r_o^2 - r_i^2);
    sh = A + B ./ r.^2;
    sr = A - B ./ r.^2;
    sa = A * ones(size(r));

    vm = sqrt(0.5*((sh-sr).^2 + (sr-sa).^2 + (sa-sh).^2));
    SF_min_arr(i) = min(sigma_y ./ vm);

    % Heat flux
    Q_arr(i) = 2*pi*k*L*(T_i - T_o) / log(r_o/r_i);
end

% Find minimum safe thickness
safe_idx = find(SF_min_arr >= SF_req, 1, 'first');
if ~isempty(safe_idx)
    t_safe = thickness_range(safe_idx)*1000;
    fprintf('Study A: Minimum wall thickness for SF >= %.1f : %.1f mm\n', SF_req, t_safe);
else
    fprintf('Study A: No thickness in range achieves SF >= %.1f\n', SF_req);
end

% ============================================================
%  STUDY B: Internal Pressure vs Minimum Safety Factor
% ============================================================
r_o          = r_i + 0.05;    % Fixed outer radius (50 mm wall)
p_range      = linspace(1e6, 50e6, 80);   % 1 to 50 MPa
SF_vs_p      = zeros(size(p_range));

for i = 1:length(p_range)
    p   = p_range(i);
    r   = linspace(r_i, r_o, 200);
    A   = p * r_i^2 / (r_o^2 - r_i^2);
    B   = p * r_i^2 * r_o^2 / (r_o^2 - r_i^2);
    sh  = A + B ./ r.^2;
    sr  = A - B ./ r.^2;
    sa  = A * ones(size(r));
    vm  = sqrt(0.5*((sh-sr).^2 + (sr-sa).^2 + (sa-sh).^2));
    SF_vs_p(i) = min(sigma_y ./ vm);
end

% Max safe pressure
safe_p_idx = find(SF_vs_p >= SF_req, 1, 'last');
if ~isempty(safe_p_idx)
    p_max_safe = p_range(safe_p_idx)/1e6;
    fprintf('Study B: Maximum safe pressure (SF >= %.1f) : %.1f MPa\n', SF_req, p_max_safe);
end

% ============================================================
%  PLOTTING
% ============================================================

% --- Figure 1: Wall Thickness vs SF and Heat Flux ---
figure('Name','Study A – Thickness Effects','NumberTitle','off', ...
       'Color','white','Position',[100 100 850 500]);

yyaxis left
plot(thickness_range*1000, SF_min_arr, 'b-', 'LineWidth', 2.5); hold on;
yline(SF_req, 'b--', 'LineWidth', 1.5);
if ~isempty(safe_idx)
    xline(t_safe, 'k:', 'LineWidth', 1.5);
    plot(t_safe, SF_min_arr(safe_idx), 'bs', 'MarkerFaceColor','b','MarkerSize',10);
    text(t_safe+1, SF_min_arr(safe_idx)-0.3, ...
         sprintf('t_{min} = %.1f mm', t_safe),'FontSize',10,'Color','b','FontWeight','bold');
end
ylabel('Minimum Safety Factor, SF_{min}', 'FontSize',12,'FontWeight','bold','Color','b');
ylim([0, max(SF_min_arr)*1.1]);

yyaxis right
plot(thickness_range*1000, Q_arr/1000, 'r-', 'LineWidth', 2.0);
ylabel('Heat Flux, Q  (kW/m)', 'FontSize',12,'FontWeight','bold','Color','r');

xlabel('Wall Thickness, t  (mm)', 'FontSize',12,'FontWeight','bold');
title({'Parametric Study A: Wall Thickness vs Safety Factor & Heat Flux'; ...
       sprintf('p_i = %.0f MPa | \\sigma_y = %.0f MPa | r_i = %.0f mm', ...
               p_i/1e6, sigma_y/1e6, r_i*1000)}, ...
      'FontSize',13,'FontWeight','bold');
legend('SF_{min}', sprintf('SF_{req} = %.1f', SF_req), ...
       't_{min safe}', 'Heat flux Q', 'Location','east','FontSize',10);
grid on; grid minor;
set(gca,'FontSize',11,'LineWidth',1.2);
box on;

% --- Figure 2: Pressure vs SF ---
figure('Name','Study B – Pressure vs SF','NumberTitle','off', ...
       'Color','white','Position',[200 150 750 480]);

plot(p_range/1e6, SF_vs_p, 'm-', 'LineWidth', 2.5); hold on;
yline(SF_req, 'r--', 'LineWidth', 2);
if ~isempty(safe_p_idx)
    xline(p_max_safe, 'k:', 'LineWidth', 1.5);
    plot(p_max_safe, SF_vs_p(safe_p_idx), 'rs','MarkerFaceColor','r','MarkerSize',11);
    text(p_max_safe+0.5, SF_vs_p(safe_p_idx)+0.15, ...
         sprintf('p_{max} = %.1f MPa', p_max_safe), ...
         'FontSize',10,'Color','r','FontWeight','bold');
end

xlabel('Internal Pressure, p_i  (MPa)', 'FontSize',12,'FontWeight','bold');
ylabel('Minimum Safety Factor, SF_{min}', 'FontSize',12,'FontWeight','bold');
title({'Parametric Study B: Internal Pressure vs Safety Factor'; ...
       sprintf('t = %.0f mm | \\sigma_y = %.0f MPa | r_i = %.0f mm', ...
               (r_o-r_i)*1000, sigma_y/1e6, r_i*1000)}, ...
      'FontSize',13,'FontWeight','bold');
legend('SF_{min} vs pressure', sprintf('SF_{req} = %.1f',SF_req), ...
       'Max safe pressure','Location','northeast','FontSize',10);
grid on; grid minor;
xlim([0, max(p_range/1e6)]);
ylim([0, max(SF_vs_p)*1.1]);
set(gca,'FontSize',11,'LineWidth',1.2);
box on;

fprintf('\n--- Summary Table ---\n');
fprintf('%-30s %-15s %-15s\n', 'Parameter', 'Value', 'Unit');
fprintf('%-30s %-15.1f %-15s\n', 'Min safe wall thickness', t_safe, 'mm');
fprintf('%-30s %-15.1f %-15s\n', 'Max safe pressure', p_max_safe, 'MPa');
fprintf('%-30s %-15.1f %-15s\n', 'Required safety factor', SF_req, '-');
fprintf('\n[Script 4 complete] Parametric study done.\n');
