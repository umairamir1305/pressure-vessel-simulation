% =========================================================
%  MASTER RUNNER — Pressure Vessel Analysis Suite
%  Run this file to execute all scripts in order.
%
%  Author : [Your Name]
%  Course : Mechanical Engineering — 4th Semester
%  Date   : 2024
%
%  Project: Thermal & Structural Analysis of a Thick-Walled
%           Cylindrical Pressure Vessel
% =========================================================

clc; clear; close all;

fprintf('\n');
fprintf('##############################################\n');
fprintf('#                                            #\n');
fprintf('#   PRESSURE VESSEL ANALYSIS SUITE          #\n');
fprintf('#   Thermal + Structural + Safety           #\n');
fprintf('#                                            #\n');
fprintf('##############################################\n\n');

fprintf('Running all analysis scripts...\n\n');
fprintf('----------------------------------------------\n');

%% Script 1 — Thermodynamics
fprintf('\n>>> Running Script 1: Heat Conduction...\n');
run('script1_heat_conduction.m');
fprintf('----------------------------------------------\n');

%% Script 2 — Strength of Materials
fprintf('\n>>> Running Script 2: Stress Analysis...\n');
run('script2_stress_analysis.m');
fprintf('----------------------------------------------\n');

%% Script 3 — Safety Factor
fprintf('\n>>> Running Script 3: Safety Factor...\n');
run('script3_safety_factor.m');
fprintf('----------------------------------------------\n');

%% Script 4 — Parametric Study
fprintf('\n>>> Running Script 4: Parametric Study...\n');
run('script4_parametric_study.m');
fprintf('----------------------------------------------\n');

fprintf('\n##############################################\n');
fprintf('#   ALL SCRIPTS COMPLETE                     #\n');
fprintf('#   Check figures for plots                  #\n');
fprintf('##############################################\n\n');
