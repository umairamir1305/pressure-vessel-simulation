# Pressure Vessel Thermal & Structural Analysis — MATLAB

A multi-physics simulation of a thick-walled cylindrical pressure vessel, combining **Thermodynamics**, **Strength of Materials**, and **Fluid Mechanics** principles into one cohesive MATLAB project.

---

## Project Overview

This project simulates a steel pressure vessel (as used in boilers, pipelines, and chemical reactors) and answers three engineering questions:

1. **How does temperature vary through the vessel wall?** (Heat conduction)
2. **How do stresses distribute through the wall under pressure?** (Lamé equations)
3. **Is the design safe — and what are its limits?** (Von Mises + Safety Factor)

---

## Scripts

| File | Topic | Physics |
|------|-------|---------|
| `script1_heat_conduction.m` | Radial temperature profile | Fourier's Law (cylindrical) |
| `script2_stress_analysis.m` | Hoop & radial stress | Lamé equations |
| `script3_safety_factor.m` | Von Mises safety factor | Failure theory |
| `script4_parametric_study.m` | Thickness & pressure sweep | Combined |
| `RUN_ALL.m` | Master runner | Runs all scripts |

---

## How to Run

1. Open MATLAB
2. Navigate to this folder (`cd` or use the folder browser)
3. Run `RUN_ALL.m` — all scripts execute in order and produce plots

Or run each script individually for step-by-step results.

---

## Vessel Parameters

| Parameter | Value | Unit |
|-----------|-------|------|
| Inner radius | 100 | mm |
| Outer radius | 150 | mm |
| Wall thickness | 50 | mm |
| Internal pressure | 10 | MPa |
| Inner wall temperature | 300 | °C |
| Outer wall temperature | 50 | °C |
| Material | Steel | — |
| Thermal conductivity (k) | 50 | W/m·K |
| Yield strength | 250 | MPa |

---

## Key Results

- **Maximum temperature** at inner surface: 300°C, dropping non-linearly to 50°C at outer surface
- **Maximum hoop stress** at inner surface (as predicted by Lamé theory)
- **Minimum safety factor** at inner surface — the critical failure location
- **Parametric study** reveals the minimum safe wall thickness and maximum allowable pressure

---

## Theory

### 1. Heat Conduction (Cylindrical)
Temperature distribution in a hollow cylinder with fixed boundary temperatures:

```
T(r) = T_inner - [Q / (2πkL)] × ln(r / r_i)

where Q = 2πkL(T_i - T_o) / ln(r_o / r_i)
```

### 2. Lamé Equations (Thick-Walled Cylinder)
For internal pressure only:

```
σ_hoop(r)   = A + B/r²     (tensile, max at inner surface)
σ_radial(r) = A - B/r²     (compressive at inner surface)

where:
  A = p_i × r_i² / (r_o² - r_i²)
  B = p_i × r_i² × r_o² / (r_o² - r_i²)
```

### 3. Von Mises Failure Criterion
```
σ_vm = √[ 0.5 × ((σ_h - σ_r)² + (σ_r - σ_a)² + (σ_a - σ_h)²) ]

Safety Factor: SF(r) = σ_yield / σ_vm(r)
```

---

## Sample Output Plots

**Script 1** — Temperature drops from 300°C to 50°C non-linearly across the 50 mm wall

**Script 2** — Hoop stress decreases from maximum at inner surface outward; radial stress goes from −p_i to 0

**Script 3** — Safety factor is lowest at inner surface; Von Mises stress peaks there

**Script 4** — Thicker walls increase SF but reduce heat flux; higher pressure reduces SF non-linearly

---

## Skills Demonstrated

- MATLAB programming (arrays, loops, plotting, annotations)
- Applied thermodynamics — Fourier heat conduction
- Applied mechanics — Lamé thick-cylinder theory
- Failure analysis — Von Mises criterion and safety factors
- Parametric design studies
- Engineering judgment and result interpretation

---

## Author

**[Your Name]**  
B.E. Mechanical Engineering — 4th Semester  
[Your University Name]

---

## References

1. Cengel & Boles — *Thermodynamics: An Engineering Approach*
2. Shigley's — *Mechanical Engineering Design*
3. Lame, G. — *Leçons sur la théorie mathématique de l'élasticité des corps solides* (1852)
