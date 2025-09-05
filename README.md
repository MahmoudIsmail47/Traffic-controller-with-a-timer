# Traffic Controller with a Timer (Verilog)

This repository contains the design and verification of a **Traffic Light Controller** implemented in **Verilog HDL**, tested on **ModelSim** and **Vivado**.  

The system manages traffic signals at a four-way intersection with programmable timing, pedestrian request handling, and a timer-driven FSM for safe and efficient traffic flow.  

---

## ✨ Features
- **Four-way traffic intersection** with Red, Yellow, and Green lights.  
- **Programmable timing**:  
  - Green = 10s  
  - Yellow = 3s  
  - Pedestrian request extends green by +5s.  
- **Clock divider**: converts FPGA base clock (10 ns) into 1-second system clock.  
- **Counter block**: controls cycle duration and generates `ctrl` signal.  
- **Mealy FSM**: manages traffic light states:  
  - `S0`: North-South Green, West-East Red  
  - `S1`: All Yellow (3s)  
  - `S2`: West-East Green, North-South Red  
  - `S3`: All Yellow (3s)  
- **Pedestrian request option**: dynamically extends cycle length.  
- Fully **verified in ModelSim** and synthesized/implemented in **Vivado**.  

---
## 🚦 Design Overview

### ⏱️ Clock Divider
- Reduces FPGA input clock (e.g., 100 MHz) down to 1 Hz.  
- Provides a **1-second timing base** for the counter.  

### 🔢 Counter
- Operates with the divided clock.  
- Counts cycle length depending on **pedestrian request** (`req`):  
  - `req = 0`: counts up to 12 (Green 10s + Yellow 3s).  
  - `req = 1`: counts up to 18 (Green 15s + Yellow 3s).  
- Outputs `ctrl` signal to FSM.  

### 🧠 FSM (Mealy)
- Controls light states based on `ctrl` from counter:  
  - `S0`: North-South Green, West-East Red.  
  - `S1`: All Yellow (3s).  
  - `S2`: West-East Green, North-South Red.  
  - `S3`: All Yellow (3s).  

---
