% =========================================================
%  SCRIPT 2: Stress Distribution Using Lamé Equations
%  Subject:  Strength of Materials
%  Theory:   Thick-walled cylinder under internal pressure
%
%            Lamé Constants:
%              A =  p_i * r_i^2 / (r_o^2 - r_i^2)
%              B =  p_i * r_i^2 * r_o^2 / (r_o^2 - r_i^2)
%
%            Hoop (circumferential) stress:
%              sigma_h(r) = A + B/r^2
%
%            Radial stress:
%              sigma_r(r) = A - B/r^2
% =========================================================

clc; clear; close all;

fprintf('==============================================\n');
fprintf('  SCRIPT 2: Structural Stress Analysis\n');
fprintf('==============================================\n\n');

% ---------- Geometry & Loading ----------
r_i  = 0.10;          % Inner radius (m)
r_o  = 0.15;          % Outer radius (m)
p_i  = 10e6;          % Internal pressure (Pa)  — 10 MPa
p_o  = 0;             % External pressure (Pa)  — atmospheric neglected

% ---------- Radial Discretisation ----------
r = linspace(r_i, r_o, 500);

% ---------- Lamé Constants ----------
A = (p_i*r_i^2 - p_o*r_o^2) / (r_o^2 - r_i^2);
B = (p_i - p_o) * r_i^2 * r_o^2 / (r_o^2 - r_i^2);

% ---------- Stress Distributions ----------
sigma_hoop   =  A + B ./ r.^2;    % Pa  (always tensile = positive)
sigma_radial =  A - B ./ r.^2;    % Pa  (compressive at inner = negative)

% Convert to MPa for readability
sigma_hoop_MPa   = sigma_hoop   / 1e6;
sigma_radial_MPa = sigma_radial / 1e6;

% ---------- Key Values ----------
sh_inner = (A + B/r_i^2) / 1e6;
sh_outer = (A + B/r_o^2) / 1e6;
sr_inner = (A - B/r_i^2) / 1e6;   % should equal -p_i
sr_outer = (A - B/r_o^2) / 1e6;   % should equal -p_o ≈ 0

fprintf('Internal pressure     : %.1f MPa\n', p_i/1e6);
fprintf('Inner radius          : %.3f m\n', r_i);
fprintf('Outer radius          : %.3f m\n', r_o);
fprintf('\n--- Hoop Stress ---\n');
fprintf('  At inner surface (r = %.2f m): %.2f MPa  ← MAXIMUM\n', r_i, sh_inner);
fprintf('  At outer surface (r = %.2f m): %.2f MPa\n', r_o, sh_outer);
fprintf('\n--- Radial Stress ---\n');
fprintf('  At inner surface (r = %.2f m): %.2f MPa  (= -p_i, check)\n', r_i, sr_inner);
fprintf('  At outer surface (r = %.2f m): %.2f MPa  (≈ 0, check)\n',   r_o, sr_outer);

% ---------- Plot ----------
figure('Name','Script 2 – Stress Distribution','NumberTitle','off', ...
       'Color','white','Position',[150 100 750 500]);

plot(r*1000, sigma_hoop_MPa,   'b-',  'LineWidth', 2.5); hold on;
plot(r*1000, sigma_radial_MPa, 'r--', 'LineWidth', 2.5);
yline(0, 'k:', 'LineWidth', 1);

% Mark critical points
plot(r_i*1000, sh_inner, 'b^', 'MarkerFaceColor','b', 'MarkerSize',10);
plot(r_i*1000, sr_inner, 'rv', 'MarkerFaceColor','r', 'MarkerSize',10);
plot(r_o*1000, sh_outer, 'b^', 'MarkerFaceColor','cyan', 'MarkerSize',10);
plot(r_o*1000, sr_outer, 'rv', 'MarkerFaceColor','#FFA07A', 'MarkerSize',10);

% Annotations
text(r_i*1000+0.3, sh_inner+1.5, sprintf('%.1f MPa', sh_inner), ...
     'FontSize',10,'Color','b','FontWeight','bold');
text(r_i*1000+0.3, sr_inner-2.5, sprintf('%.1f MPa', sr_inner), ...
     'FontSize',10,'Color','r','FontWeight','bold');
text(r_o*1000-5, sh_outer+1.5, sprintf('%.1f MPa', sh_outer), ...
     'FontSize',10,'Color','b');
text(r_o*1000-5, sr_outer+1.5, sprintf('≈ 0'), ...
     'FontSize',10,'Color','r');

% Wall shading
patch([r_i r_o r_o r_i]*1000, ...
      [min(sigma_radial_MPa)-3 min(sigma_radial_MPa)-3 ...
       max(sigma_hoop_MPa)+3   max(sigma_hoop_MPa)+3], ...
      [0.95 0.95 0.85], 'FaceAlpha', 0.2, 'EdgeColor','none');

xlabel('Radial Position, r  (mm)',   'FontSize', 12, 'FontWeight','bold');
ylabel('Stress, \sigma  (MPa)',       'FontSize', 12, 'FontWeight','bold');
title({'Hoop & Radial Stress Distribution — Lamé Equations'; ...
       sprintf('p_i = %.0f MPa  |  r_i = %.0f mm  |  r_o = %.0f mm', ...
               p_i/1e6, r_i*1000, r_o*1000)}, ...
      'FontSize', 13, 'FontWeight','bold');

legend('Hoop stress \sigma_{\theta}', 'Radial stress \sigma_r', ...
       'Zero line', 'Location','east','FontSize',11);
grid on; grid minor;
xlim([r_i*1000 - 1,  r_o*1000 + 1]);
set(gca,'FontSize',11,'LineWidth',1.2);
box on;

fprintf('\n[Script 2 complete] Stress distributions plotted.\n');
