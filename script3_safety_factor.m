% =========================================================
%  SCRIPT 3: Von Mises Safety Factor Analysis
%  Subject:  Strength of Materials + Thermodynamics combined
%  Theory:   Von Mises equivalent stress:
%              sigma_vm = sqrt(sigma_h^2 - sigma_h*sigma_r + sigma_r^2)
%
%            Safety Factor:
%              SF(r) = sigma_yield / sigma_vm(r)
%
%  Note: For a cylinder, sigma_axial = (sigma_h + sigma_r)/2
%        We use the full 3D Von Mises criterion.
% =========================================================

clc; clear; close all;

fprintf('==============================================\n');
fprintf('  SCRIPT 3: Safety Factor Analysis\n');
fprintf('==============================================\n\n');

% ---------- Parameters ----------
r_i       = 0.10;        % Inner radius (m)
r_o       = 0.15;        % Outer radius (m)
p_i       = 10e6;        % Internal pressure (Pa)
p_o       = 0;           % External pressure (Pa)
sigma_y   = 250e6;       % Yield strength of steel (Pa)  — 250 MPa
SF_min_ok = 2.0;         % Minimum acceptable safety factor (design standard)

r = linspace(r_i, r_o, 500);

% ---------- Lamé Stresses ----------
A = (p_i*r_i^2 - p_o*r_o^2) / (r_o^2 - r_i^2);
B = (p_i - p_o) * r_i^2 * r_o^2 / (r_o^2 - r_i^2);

sigma_h = A + B ./ r.^2;          % Hoop stress (Pa)
sigma_r = A - B ./ r.^2;          % Radial stress (Pa)
sigma_a = A * ones(size(r));       % Axial stress (closed-end vessel)

% ---------- Von Mises Equivalent Stress ----------
sigma_vm = sqrt( 0.5 * ( (sigma_h - sigma_r).^2 + ...
                          (sigma_r - sigma_a).^2 + ...
                          (sigma_a - sigma_h).^2 ) );

% ---------- Safety Factor ----------
SF = sigma_y ./ sigma_vm;

% ---------- Critical Points ----------
[SF_min, idx_min] = min(SF);
[SF_max, idx_max] = max(SF);
r_critical = r(idx_min);

% ---------- Failure Check ----------
fprintf('Material yield strength  : %.0f MPa\n', sigma_y/1e6);
fprintf('Minimum SF required      : %.1f\n', SF_min_ok);
fprintf('\n--- Safety Factor Results ---\n');
fprintf('  Minimum SF = %.3f  at r = %.4f m (%.1f mm)  ← CRITICAL POINT\n', ...
        SF_min, r_critical, r_critical*1000);
fprintf('  Maximum SF = %.3f  at r = %.4f m (%.1f mm)\n', ...
        SF_max, r(idx_max), r(idx_max)*1000);

if SF_min >= SF_min_ok
    verdict = 'SAFE';
    color_verdict = 'Design is SAFE';
    fprintf('\n  VERDICT: %s — SF_min (%.2f) >= SF_required (%.1f)\n', ...
            verdict, SF_min, SF_min_ok);
else
    verdict = 'UNSAFE';
    color_verdict = 'Design is UNSAFE!';
    fprintf('\n  VERDICT: %s — SF_min (%.2f) < SF_required (%.1f)\n', ...
            verdict, SF_min, SF_min_ok);
    fprintf('  Recommendation: Increase wall thickness or reduce pressure.\n');
end

% ---------- Plot 1: Safety Factor Distribution ----------
figure('Name','Script 3 – Safety Factor','NumberTitle','off', ...
       'Color','white','Position',[200 100 750 500]);

% Colour the plot by safe/unsafe regions
hold on;
fill([r r(end) r(1)]*1000, [SF SF(end)*0 SF(1)*0+0], ...
     [0.8 1 0.8], 'EdgeColor','none', 'FaceAlpha', 0.4);  % green bg
yline(SF_min_ok, 'r--', 'LineWidth', 2.0);

plot(r*1000, SF, 'b-', 'LineWidth', 2.5);

% Critical point marker
plot(r_critical*1000, SF_min, 'rv', 'MarkerFaceColor','r', 'MarkerSize',12);
text(r_critical*1000 + 0.3, SF_min - 0.15, ...
     sprintf('SF_{min} = %.2f\n at r = %.1f mm', SF_min, r_critical*1000), ...
     'FontSize', 10, 'Color', 'r', 'FontWeight','bold');

% Required SF line label
text(r_o*1000 - 6, SF_min_ok + 0.12, ...
     sprintf('SF_{required} = %.1f', SF_min_ok), ...
     'FontSize', 10, 'Color','r');

% Verdict box
annotation('textbox', [0.60 0.75 0.28 0.12], ...
           'String', color_verdict, ...
           'FontSize', 12, 'FontWeight','bold', ...
           'HorizontalAlignment','center', ...
           'BackgroundColor', [0.85 1.0 0.85], ...
           'EdgeColor', [0 0.6 0], 'LineWidth', 1.5);

xlabel('Radial Position, r  (mm)',      'FontSize', 12, 'FontWeight','bold');
ylabel('Safety Factor, SF',             'FontSize', 12, 'FontWeight','bold');
title({'Von Mises Safety Factor Distribution'; ...
       sprintf('\\sigma_y = %.0f MPa  |  p_i = %.0f MPa', ...
               sigma_y/1e6, p_i/1e6)}, ...
      'FontSize', 13, 'FontWeight','bold');
legend('Safe zone','SF_{required}','Safety factor profile','Critical point', ...
       'Location','northeast','FontSize',10);
grid on; grid minor;
xlim([r_i*1000 - 1, r_o*1000 + 1]);
ylim([0, max(SF)*1.15]);
set(gca,'FontSize',11,'LineWidth',1.2);
box on;

% ---------- Plot 2: Von Mises Stress ----------
figure('Name','Script 3 – Von Mises Stress','NumberTitle','off', ...
       'Color','white','Position',[250 150 750 500]);

plot(r*1000, sigma_vm/1e6, 'm-', 'LineWidth', 2.5); hold on;
yline(sigma_y/1e6, 'r--', 'LineWidth', 2);

plot(r_critical*1000, sigma_vm(idx_min)/1e6, 'rv', ...
     'MarkerFaceColor','r','MarkerSize',12);

text(r_critical*1000+0.3, sigma_vm(idx_min)/1e6 + 2, ...
     sprintf('\\sigma_{vm,max} = %.1f MPa', sigma_vm(idx_min)/1e6), ...
     'FontSize',10,'Color','m','FontWeight','bold');
text(r_o*1000-6, sigma_y/1e6+2, ...
     sprintf('\\sigma_y = %.0f MPa', sigma_y/1e6), ...
     'FontSize',10,'Color','r');

xlabel('Radial Position, r  (mm)',          'FontSize', 12, 'FontWeight','bold');
ylabel('Von Mises Stress, \sigma_{vm} (MPa)','FontSize', 12, 'FontWeight','bold');
title({'Von Mises Equivalent Stress Distribution'; ...
       'Compared Against Yield Strength'}, ...
      'FontSize', 13, 'FontWeight','bold');
legend('\sigma_{vm} profile','Yield strength \sigma_y','Peak stress point', ...
       'Location','northeast','FontSize',10);
grid on; grid minor;
xlim([r_i*1000-1, r_o*1000+1]);
set(gca,'FontSize',11,'LineWidth',1.2);
box on;

fprintf('\n[Script 3 complete] Safety factor & Von Mises stress plotted.\n');
