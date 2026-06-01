# Computational Modelling of Respiratory Responses

> A MATLAB/Simulink-based computational study simulating the dynamics of gas exchange and respiratory control using differential equations and mathematical models from respiratory physiology literature.

**Author:** Debanjan Kola  
**Guide:** Dr. Tanmay Pal  
**Institution:** Indian Institute of Engineering Science and Technology (IIEST), Shibpur  
**Fellowship:** Summer Research Fellowship 2024 — IASc / INSA / NASI

---

## Overview

The respiratory system governs the critical process of gas exchange — supplying oxygen (O₂) to the body and expelling carbon dioxide (CO₂). Understanding its dynamics mathematically is essential for diagnosing respiratory diseases, designing ventilators, and advancing personalized medicine.

This project builds and simulates a **computational model of respiratory responses** using a set of coupled differential equations implemented in **MATLAB and Simulink**. The models cover respiratory frequency, alveolar gas pressure dynamics, ventilation control, and oxygen sensitivity — simulated under both inspiration and expiration conditions.

---

## Mathematical Framework

The project implements and simulates six interconnected models derived from established respiratory physiology literature (Otis et al., 1950; Batzel et al., 2007).

---

### Model 1 — Ventilation Rate

The ratio of alveolar ventilation to basal ventilation is governed by:

```
V̇_A / V̇_Abasal = 0.2332·PbCO₂ + 0.2025·PaCO₂ + G3 + MRV + β
```

Where **G3** captures the nonlinear effect of arterial O₂ pressure:

```
G3 = 4.72×10⁻⁹ × (104 − PaO₂)^4.9    if PaO₂ ≤ 104 Torr
G3 = 0                                   if PaO₂ > 104 Torr
```

**Result:** With PaO₂ = 100 mmHg, PaCO₂ = 40 mmHg, PbCO₂ = 46 mmHg → output ≈ **1.243** (near-basal ventilation, indicating resting state).

---

### Model 2 — Respiratory Frequency (Otis et al.)

Breathing rate is optimized by minimizing the work of breathing:

```
fR = [ −Ers·VD + √((Ers·VD)² + 4·Ers·Rrs·π²·VD·V̇A) ] / [ 2π²·Rrs·VD ]
```

| Parameter | Meaning |
|-----------|---------|
| `Ers` | Respiratory system elastance |
| `VD` | Physiological dead space volume |
| `Rrs` | Respiratory system resistance |
| `V̇A` | Alveolar ventilation rate |

**Result:** Output = **0.2206 Hz** → **13.23 breaths/minute**  (normal adult respiratory rate)

---

### Model 3 — Alveolar CO₂ Pressure (Inspiration)

```
dP_ACO₂/dt = [ V̇T(Pd(5)CO₂ − PACO₂) + 863·Q̇T(CvCO₂ − CaCO₂) + Q̇B(CBCO₂ − CaCO₂) ]
              / (VLCO₂ + VT)
```

**Key parameters:** V̇A = 0.5 L/s, Pd(5)CO₂ = 45 mmHg, Q̇T = Q̇B = 0.083 L/s, CVCO₂ = 48 ml CO₂/L blood, VLCO₂ = 2 L

**Result:** System stabilizes at **39.21 mmHg** (expected normal ≈ 40 mmHg), demonstrating correct homeostatic return from a simulated hypoventilation state starting at 81 mmHg.

---

### Model 4 — Alveolar O₂ Pressure (Inspiration)

```
dP_AO₂/dt = [ V̇T(Pd(5)O₂ − PAO₂) + 863·Q̇T(CvO₂ − CaO₂) + Q̇B(CBO₂ − CaO₂) ]
             / (VLO₂ + VT)
```

**Result:** Output transitions from **1.5 mmHg → 1.095 mmHg**, reflecting dynamic oxygen pressure adjustment due to ventilation and perfusion interactions.

---

### Model 5 — Simplified Alveolar CO₂ (Expiration)

```
dP_ACO₂/dt = −863·[ Q̇T(CvCO₂ − CaCO₂) + Q̇B(CBCO₂ − CaCO₂) ] / (VLCO₂ + VT)
```

**Result:** Output = **−50.52 mmHg/s** (rising from −92 mmHg/s), reflecting CO₂ washout during expiration.

---

### Model 6 — Simplified Alveolar O₂ (Expiration)

```
dP_AO₂/dt = −863·[ Q̇T(CvO₂ − CaO₂) + Q̇B(CBO₂ − CaO₂) ] / (VLO₂ + VT)
```

**Result:** Output = **−76.77 mmHg/s**, indicating a rapid decline in arterial O₂ pressure — clinically significant as a potential marker for hypoxemia or ventilation-perfusion mismatch.

---

##  Tools & Implementation

| Tool | Purpose |
|------|---------|
| **MATLAB** | Mathematical formulation, G3 function, parameter estimation |
| **Simulink** | Block diagram simulation of differential equations |

All models were implemented as Simulink block diagrams with subsystems for modular organization. Integration blocks (`1/s`) were used for differential equation simulation and outputs were verified against known physiological reference values.

---

## Key Physiological Concepts Modelled

- **Respiratory Mechanics** — Airway resistance, lung elastance, dead space volume
- **Alveolar Gas Exchange** — O₂ and CO₂ partial pressure dynamics during breathing cycles
- **Ventilation Control** — Neural and chemoreceptor-driven regulation via CO₂/O₂ feedback
- **Homeostasis Simulation** — Return to normal gas pressures from disturbed initial conditions
- **Apnea Condition** — Detection of inadmissible negative ventilation rates under acute hypoxia

---


