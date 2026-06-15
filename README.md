# 🔥 SystemVerilog-Based Fire Alarm System

A digital logic fire alarm system designed and verified using **SystemVerilog**, implemented in three modeling styles: Gate-Level (NOR), Dataflow (NAND), and Behavioral (Case Block).

> **Institution:** NMAM Institute of Technology, Nitte (NITTE Deemed to be University)  
> **Department:** Electronics & Communication Engineering  
> **Academic Year:** 2024–2025

---

## 👥 Team Members

| Name | USN |
|---|---|
| MOHAMMED ARSH IRSHAD | NNM23EC096 |

---

## 📌 Project Overview

Large buildings divided into multiple zones need intelligent fire alarm systems that can provide **localized** as well as **full-scale** emergency responses.

This project models a **4-zone fire detection system**:

| Zone | Side |
|---|---|
| A, B | Left |
| C, D | Right |

### Outputs

| Output | Meaning | Condition |
|---|---|---|
| **Y1** | Left extinguisher activated | Fire in Zone A **OR** B |
| **Y2** | Right extinguisher activated | Fire in Zone C **OR** D |
| **Y3** | Master alert (main power + fire brigade) | Fire in **3 or more** zones simultaneously |

---

## 🧮 Truth Table

| A | B | C | D | Y1 | Y2 | Y3 |
|---|---|---|---|----|----|-----|
| 0 | 0 | 0 | 0 | 0  | 0  | 0  |
| 0 | 0 | 0 | 1 | 0  | 1  | 0  |
| 0 | 0 | 1 | 0 | 0  | 1  | 0  |
| 0 | 0 | 1 | 1 | 0  | 1  | 0  |
| 0 | 1 | 0 | 0 | 1  | 0  | 0  |
| 0 | 1 | 0 | 1 | 1  | 1  | 1  |
| 0 | 1 | 1 | 0 | 1  | 1  | 1  |
| 0 | 1 | 1 | 1 | 1  | 1  | 1  |
| 1 | 0 | 0 | 0 | 1  | 0  | 0  |
| 1 | 0 | 0 | 1 | 1  | 1  | 1  |
| 1 | 0 | 1 | 0 | 1  | 1  | 1  |
| 1 | 0 | 1 | 1 | 1  | 1  | 1  |
| 1 | 1 | 0 | 0 | 1  | 0  | 0  |
| 1 | 1 | 0 | 1 | 1  | 1  | 1  |
| 1 | 1 | 1 | 0 | 1  | 1  | 1  |
| 1 | 1 | 1 | 1 | 1  | 1  | 1  |

**Logic Equations:**
```
Y1 = A | B
Y2 = C | D
Y3 = Y1 & Y2 = (A | B) & (C | D)
```

---

## 📁 Repository Structure

```
fire-alarm-sv/
│
├── src/
│   ├── dataflow/
│   │   ├── NandDataflow.sv        # Dataflow module (NAND gates only)
│   │   └── andlogic_pkg.sv        # OOP reference model package
│   │
│   ├── behavioral/
│   │   ├── logic_function.sv      # Behavioral module (case block)
│   │   └── LogicFunction.sv       # OOP reference model package
│   │
│   └── gate_level/
│       ├── FASnor.sv              # Gate-level module (NOR gates only)
│       └── mygate.sv              # NOR gate class package
│
├── tb/
│   ├── tb_NandDataflow.sv         # Testbench for dataflow module
│   ├── logic_function_tb.sv       # Testbench for behavioral module
│   └── testbench.sv               # Testbench for gate-level module
│
├── docs/
│   └── Fire_Alarm_System_Report.pdf   # Full project report
│
├── sim/
│   └── (Add waveform screenshots here)
│
└── README.md
```

---

## 🛠️ Implementation Styles

### 1. Gate-Level (NOR Only) — `src/gate_level/`
- Built entirely from **NOR gates** (universal gate)
- OR and AND operations derived using NOR combinations
- Self-checking testbench using `norgate` class

### 2. Dataflow (NAND Only) — `src/dataflow/`
- Uses **continuous assignments** with NAND gate expressions
- OR derived using DeMorgan's theorem: `A | B = ~(~A & ~B)`
- OOP reference model for self-checking

### 3. Behavioral (Case Block) — `src/behavioral/`
- **High-level abstraction** using `always @(*)` and `case`
- Easiest to read and verify
- Task-based testbench with reference class comparison

---

## ✅ Verification Strategy

| Style | Testbench Type | Method |
|---|---|---|
| Gate-Level | Self-Checking | `norgate` class mirrors DUT gate network |
| Dataflow | Self-Checking | OOP classes compute expected Y1, Y2, Y3 |
| Behavioral | Task-Based | Reusable task + `LogicFunction` class |

All testbenches iterate through **all 16 input combinations** and report PASS/FAIL.

---

## 🚀 How to Run

### Using Vivado
1. Create a new project in **Vivado**
2. Add source files from `src/<style>/`
3. Add testbench from `tb/`
4. Run **Behavioral Simulation**
5. View waveforms in the Waveform Viewer

### Using ModelSim
```bash
# Example for Gate-Level
vlog src/gate_level/mygate.sv src/gate_level/FASnor.sv tb/testbench.sv
vsim testbench
run -all
```

```bash
# Example for Dataflow
vlog src/dataflow/andlogic_pkg.sv src/dataflow/NandDataflow.sv tb/tb_NandDataflow.sv
vsim tb_NandDataflow
run -all
```

```bash
# Example for Behavioral
vlog src/behavioral/LogicFunction.sv src/behavioral/logic_function.sv tb/logic_function_tb.sv
vsim logic_function_tb
run -all
```

---

## 📊 Results

All three implementations were tested against **16 input combinations** and produced outputs matching the expected truth table with **zero mismatches**.

| Style | Test Cases | Pass | Fail |
|---|---|---|---|
| Gate-Level (NOR) | 16 | 16 | 0 |
| Dataflow (NAND) | 16 | 16 | 0 |
| Behavioral (Case) | 16 | 16 | 0 |

---

## 🔧 Tools Used

- **Xilinx Vivado** — Simulation & Synthesis
- **ModelSim** — Simulation
- **GTKWave** — Waveform Analysis
- **FPGA Board** — Xilinx Spartan (for hardware validation)

---

## 📚 References

- SystemVerilog IEEE Std 1800™-2017 LRM
- *Digital Design* — M. Morris Mano
- ModelSim User Manual
- Vivado Design Suite User Guide
- NPTEL Digital Circuits Course

---

## 📄 License

This project was submitted as part of the **Project-Based SystemVerilog Laboratory** course at NMAM Institute of Technology.  
For academic use only.
