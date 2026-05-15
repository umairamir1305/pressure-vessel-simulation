% =========================================================
%  SCRIPT 1: Radial Heat Conduction Through Vessel Wall
%  Subject:  Thermodynamics
%  Theory:   Fourier's Law for cylindrical geometry
%            Q = 2*pi*k*L*(T_inner - T_outer) / ln(r_o/r_i)
%            T(r) = T_inner - Q/(2*pi*k*L) * ln(r/r_i)
% =========================================================

clc; clear; close all;

fprintf('==============================================\n');
fprintf('  SCRIPT 1: Thermal Analysis\n');
fprintf('==============================================\n\n');

% ---------- Material & Geometry Parameters ----------
r_i  = 0.10;          % Inner radius (m)
r_o  = 0.15;          % Outer radius (m)
k    = 50;            % Thermal conductivity of steel (W/m·K)
L    = 1;             % Unit length of vessel (m)
T_i  = 300;           % Inner wall temperature (°C)
T_o  = 50;            % Outer wall temperature (°C)

% ---------- Radial Discretisation ----------
r = linspace(r_i, r_o, 500);   % 500 points across wall

% ---------- Heat Flow Rate (per unit length) ----------
Q = 2 * pi * k * L * (T_i - T_o) / log(r_o / r_i);   % W/m

% ---------- Temperature Distribution ----------
T = T_i - (Q / (2 * pi * k * L)) .* log(r / r_i);    % °C

% ---------- Results ----------
fprintf('Inner radius      : %.3f m\n', r_i);
fprintf('Outer radius      : %.3f m\n', r_o);
fprintf('Wall thickness    : %.3f m\n', r_o - r_i);
fprintf('Inner temperature : %.1f °C\n', T_i);
fprintf('Outer temperature : %.1f °C\n', T_o);
fprintf('Heat flux (Q/L)   : %.2f W/m\n', Q);
fprintf('\nTemperature at midwall (r = %.3f m): %.2f °C\n', ...
        (r_i+r_o)/2, interp1(r, T, (r_i+r_o)/2));

% ---------- Plot ----------
figure('Name','Script 1 – Heat Conduction','NumberTitle','off', ...
       'Color','white','Position',[100 100 700 480]);

plot(r*1000, T, 'r-', 'LineWidth', 2.5);
hold on;

% Mark inner and outer surfaces
plot(r_i*1000, T_i, 'ko', 'MarkerFaceColor','r', 'MarkerSize', 9);
plot(r_o*1000, T_o, 'ko', 'MarkerFaceColor','b', 'MarkerSize', 9);

% Shade the wall region
patch([r_i r_o r_o r_i]*1000, [min(T)-10 min(T)-10 max(T)+10 max(T)+10], ...
      [0.85 0.92 1.0], 'FaceAlpha', 0.25, 'EdgeColor','none');

% Midwall marker
r_mid = (r_i + r_o) / 2;
T_mid = interp1(r, T, r_mid);
plot(r_mid*1000, T_mid, 'gs', 'MarkerFaceColor','g', 'MarkerSize', 9);

% Labels
text(r_i*1000+0.3, T_i+8, sprintf('T_{inner} = %.0f°C', T_i), ...
     'FontSize',10,'Color','r','FontWeight','bold');
text(r_o*1000-5,   T_o+8, sprintf('T_{outer} = %.0f°C', T_o), ...
     'FontSize',10,'Color','b','FontWeight','bold');
text(r_mid*1000+0.3, T_mid+8, sprintf('T_{mid} = %.1f°C', T_mid), ...
     'FontSize',10,'Color',[0 0.6 0]);

xlabel('Radial Position, r  (mm)', 'FontSize', 12, 'FontWeight','bold');
ylabel('Temperature, T  (°C)',     'FontSize', 12, 'FontWeight','bold');
title({'Radial Temperature Distribution in Pressure Vessel Wall'; ...
       sprintf('k = %d W/m·K  |  Q = %.1f W/m', k, Q)}, ...
      'FontSize', 13, 'FontWeight','bold');

legend('Temperature profile','Inner surface','Outer surface','Midwall point', ...
       'Location','northeast','FontSize',10);
grid on; grid minor;
xlim([r_i*1000 - 1,  r_o*1000 + 1]);
ylim([T_o - 20,      T_i + 20]);

set(gca,'FontSize',11,'LineWidth',1.2);
box on;

fprintf('\n[Script 1 complete] Temperature profile plotted.\n');
