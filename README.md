# 32-bit 3-Cycle MIPS Processor 

## Project Overview
This repository contains the Verilog hardware code for a 32-bit MIPS processor. The design uses a 3-cycle implementation to execute instructions. This approach divides the execution process into three distinct steps to reliably meet clock timing constraints.

## 3-Cycle Execution Design
A new instruction is fetched only after the previous instruction finishes its complete 3-cycle sequence. 

* **Cycle 1:** The processor fetches the 32-bit instruction from memory, decodes it, and reads the operand values from the register file.
* **Cycle 2:** The Arithmetic Logic Unit (ALU) performs the math or logic operation, or the processor handles a system call. 
* **Cycle 3:** The final computed result is written back into the register file.

## Supported Instructions
Every instruction processed by the system is 32 bits long. The processor supports two main types of instruction formats:

### Register Instructions
* **Operations:** `add`, `sub`, `and`, `or`, `xor`, `nor`, `sll`, `sllv`, `srl`, `srlv`, `sra`, `srav`, and `syscall`.
* **System Calls:** The `syscall` instruction is used to stop the program (using code 1001) or print output values to a four-entry I/O register array (using code 1004).

### Immediate Instructions
* **Operations:** `addi`, `andi`, `ori`, `xori`.
* **Details:** The 16-bit immediate value provided in the instruction is sign-extended for arithmetic operations (like `addi`) and zero-extended for logical operations (like `andi`, `ori`, and `xori`) to create a full 32-bit number.

## Hardware Modules
The project is built using several connected Verilog modules:

* **Register File:** Contains 32 individual 32-bit registers. It features two read ports and one write port. 
* **ALU:** A combinational block that handles all the math, logic, and shift operations based on the instruction type.
* **Memory:** A word-addressable memory module used exclusively to store and fetch the 32-bit instructions.
* **Processor:** The core component that holds the Register File and the ALU. It manages the 3-cycle execution states and controls the instruction flow.
* **Computer (Top-Level):** This is the main wrapper module that connects the Processor and Memory together. It receives the raw instructions, stores them in memory, and tracks the total clock cycles used during execution.

## Testing and Simulation
The design is verified using a simulation testbench. After the simulation, the hardware is implemented as an AXI4 IP and tested by running a translated C program to confirm that it calculates and prints the correct outputs.
