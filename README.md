# Pressure Vessel Thermal & Structural Analysis in MATLAB

This project studies the behavior of a thick-walled cylindrical pressure vessel using MATLAB.
The aim was to combine concepts from heat transfer, strength of materials, and fluid/pressure systems into one engineering simulation.

The model analyzes how temperature and stresses vary through the vessel wall and checks whether the design remains within safe operating limits.

Typical applications include boilers, pressure pipelines, storage tanks, and chemical process vessels.

---

# Project Objectives

The project focuses on three main engineering problems:

1. Determining the temperature distribution through the vessel wall due to heat conduction
2. Calculating radial and hoop stresses caused by internal pressure
3. Evaluating structural safety using the Von Mises failure criterion and factor of safety

---

# MATLAB Files

| File Name                    | Purpose                                                |
| ---------------------------- | ------------------------------------------------------ |
| `script1_heat_conduction.m`  | Calculates radial temperature distribution             |
| `script2_stress_analysis.m`  | Computes hoop and radial stresses using Lamé equations |
| `script3_safety_factor.m`    | Calculates Von Mises stress and safety factor          |
| `script4_parametric_study.m` | Studies effect of pressure and wall thickness          |
| `RUN_ALL.m`                  | Runs all scripts together                              |

---

# Procedure

1. Open MATLAB
2. Set the project folder as the current directory
3. Run `RUN_ALL.m`

All graphs and calculations will be generated automatically.

Individual scripts can also be executed separately for checking each analysis step.

---

# Vessel Specifications

| Parameter              | Value | Unit  |
| ---------------------- | ----- | ----- |
| Inner radius           | 100   | mm    |
| Outer radius           | 150   | mm    |
| Wall thickness         | 50    | mm    |
| Internal pressure      | 10    | MPa   |
| Inner wall temperature | 300   | °C    |
| Outer wall temperature | 50    | °C    |
| Material               | Steel | —     |
| Thermal conductivity   | 50    | W/m·K |
| Yield strength         | 250   | MPa   |

---

# Theoretical Background

## 1. Radial Heat Conduction

The temperature distribution through the cylindrical wall is calculated using Fourier’s law for steady-state radial conduction.

[
T(r) = T_i - [ Q / (2πkL) ] ln(r / r_i)
]

where,

[
Q = [ 2πkL(T_i - T_o) ] / ln(r_o / r_i)
]

The temperature decreases non-linearly from the inner surface toward the outer surface.

---

## 2. Stress Distribution in Thick Cylinders

Stress variation through the wall is determined using Lamé equations for thick-walled pressure vessels.

[
σ_h = A + (B / r²)
]

[
σ_h = A + (B / r²)
]

where,

[
A = (p_i r_i²) / (r_o² - r_i²)
]

[
B = (p_i r_i² r_o²) / (r_o² - r_i²)
]

The hoop stress is maximum at the inner surface, while radial stress changes from compressive pressure at the inside to nearly zero at the outer surface.

---

## 3. Von Mises Criterion

Equivalent stress is calculated using the Von Mises relation:

[
σ_vm = √{ 0.5 [ (σ_h - σ_r)² + (σ_r - σ_a)² + (σ_a - σ_h)² ] }
]

Factor of safety:

[
SF = σ_y / σ_vm
]

This helps identify the critical region of the vessel and determine whether yielding may occur.

---

# Results and Observations

* Temperature decreases from 300°C at the inner wall to 50°C at the outer wall
* Maximum hoop stress occurs at the inner radius
* Radial stress is highest in compression near the inner wall and approaches zero outward
* Von Mises stress is maximum at the inner surface
* The minimum factor of safety occurs near the inner radius
* Increasing wall thickness improves safety factor
* Increasing internal pressure causes a significant rise in stresses

---

# Engineering Concepts Used

* MATLAB programming and plotting
* Steady-state heat conduction
* Thick cylinder stress analysis
* Failure theory and safety factor evaluation
* Parametric analysis and engineering design interpretation

---

# Author

Umair
Mechanical Engineering 4th Semester
National University of Sciences and Technology

---

# References

1. Thermodynamics: An Engineering Approach
2. Shigley's Mechanical Engineering Design
3. Gabriel Lamé — Theory of thick-walled cylinders
