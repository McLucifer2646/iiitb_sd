# iiitb_sd -> Sequence Detection using Moore FSM

This project simulates the design of a Sequence Detector built using the MOORE FSM logic. We can detect a pre-decided 4 bit sequence and provide an output high when the sequence is detected. The following circuit design can detect overlapping sequences.

*Note: Circuit requires further optimization to improve performance. Design yet to be modified.*

## Introduction
A sequence detector is a sequential circuit that has an output of HIGH if a specific pattern of bits arrives as input otherwise it continues to be LOW. Moore FSMs are the ones whose output value is determined using only its current state and thus the output value is independent of the previous input values.

<p align="center">
  <img width="500" height="500" src="/Images/IMG1.jpg">
</p>

## Applications

 A Sequence Detector can be used in the following areas:

- Binary sequences are inserted at the beginning (or end) of a data frame or subframe emanating from a digital data processor of a spacecraft. Sequence detectors are used in the decoding equipment on the ground to provide “flags” which indicate the beginning (or end) of a data block
- Detecting programming sequences to perform a sequence of tasks.

## Block Diagram of Sequence Detector

<p align="center">
  <img width="900" height="250" src="/Images/IMG3.jpg">
</p>



## About iverilog 
Icarus Verilog is a Verilog simulation and synthesis tool. It operates as a compiler, compiling source code written in Verilog (IEEE-1364) into some target format. For batch simulation, the compiler can generate an intermediate form called vvp assembly. This intermediate form is executed by the ``vvp'' command. For synthesis, the compiler generates netlists in the desired format.

## About GTKWave
GTKWave is a fully featured GTK+ based wave viewer for Unix, Win32, and Mac OSX which reads LXT, LXT2, VZT, FST, and GHW files as well as standard Verilog VCD/EVCD files and allows their viewing.

### Installing iverilog and GTKWave

#### For Ubuntu

Open your terminal and type the following to install iverilog and GTKWave
```
$   sudo apt-get update
$   sudo apt-get install iverilog gtkwave
```

## Functional Simulation
To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.
```
$   sudo apt install -y git
$   git clone https://github.com/McLucifer2646/iiitb_physical_design_of_asics.git

$   cd iiitb_physical_design_of_asics

$   iverilog iiitb_seq_det_moore_fsm.v iiitb_seq_det_moore_fsm_tb.v
$   ./a.out
$   gtkwave seq_det.vcd
```

## Synthesis of verilog code

### What is Yosys ??
Yosys stands for "Yosys Open SYnthesis Suite". Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains. For more information refer to the link attached below:
- https://yosyshq.net/yosys/

To install yosys follow the instructions in this GitHub repository

- https://github.com/YosysHQ/yosys

To just run commnds in this repository and for simpler installations in Ubuntu:
```
$   sudo apt-get install yosys 
```
*Note: Identify the .lib file path in cloned folder and change the path in highlighted text to indentified path*


### Synthesis
Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates.

**The two methods to proceed with the synthesis process are as follows:**
#### Method 1 - Using direct Commands

Invoke 'yosys' and execute the below commands to perform the synthesis of the above circuit.

```
$   yosys
$   yosys>    read_liberty -lib ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

$   yosys>    read_verilog iiitb_seq_det_moore_fsm.v

$   yosys>    synth -top Sequence_Detector_MOORE_Verilog

$   yosys>    abc -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

$   yosys>    clean

$   yosys>    write_verilog -noattr iiitb_sqd_synth.v
```

#### Method 2 - Using script file
The above commandscan all be run in a single step by executing the script file after invoking 'yosys' terminal.
```
$   yosys
$   yosys>    script yosys_run.sh
```

*Now the synthesized netlist is written in "iiitb_sqd_synth.v" file.*

### To view different types of cells after Synthesis
```
$   yosys>    stat
```
### To view the generated Schemantics
```
$   yosys>    show
```

### Gate Level Simulation (GLS)
GLS generates the simulation output by running test bench along with the netlist file generated from synthesis as design under test. 

Netlist is logically same as RTL code, therefore, same test bench can be used for it. We perform this to verify logical correctness of the design after synthesizing it. Also ensuring the timing of the design is satisfied. 

**Following are the commands to run the GLS simulation:**
```
$   iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 verilog_model/primitives.v verilog_model/sky130_fd_sc_hd.v iiitb_sqd_synth.v iiitb_seq_det_moore_fsm_tb.v
$   ./a.out
$   gtkwave seq_det.vcd
```

## Functional Characteristics
In this simultion result we observe three waveform namely Clock(clk), Sequence Input and Detected Output. We also observe that around 160ns the Detector displays a HIGH signal indicating that the given sequence of '1111' was detected succesfully.

<p align="center">
  <img width="1600" height="200" src="/Images/IMG4.png">
</p>

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/Netlist.png">
</p>

### Statistics after Synthesis

<p align="center">
  <img width="386" height="373" src="/Images/Stats.png">
</p>

### Pre Synthesis Simulation Result (O1)

<p align="center">
  <img width="1345" height="260" src="/Images/Pre_Synthesis.png">
</p>

### Post Synthesis Simulation Result (O2)

<p align="center">
  <img width="1345" height="260" src="/Images/Post_Synthesis.png">
</p>

**Here we observe that the pre-synthesis output O1 is equal to the post-synthesis output (O2).**

## Contributors 

- **Anshul Madurwar** 
- **Kunal Ghosh** 


## Acknowledgments

- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## Contact Information

- Anshul Madurwar, Integrated MTech Student, International Institute of Information Technology, Bangalore  Anshul.Madurwar@iiitb.ac.in
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com

## References:
- [FPGA4Student](https://www.fpga4student.com/2017/09/verilog-code-for-moore-fsm-sequence-detector.html)
- [Wikipedia](https://en.wikipedia.org/wiki/Moore_machine)
- [Study.com](https://study.com/academy/lesson/practical-application-for-computer-architecture-sequential-circuits.html#:~:text=A%20sequence%20detector%20is%20a,detectors%2C%20this%20is%20not%20allowed.)
- [Yosys](https://yosyshq.net/yosys/)
- [Applications](https://whomadewhat.org/what-are-applications-of-sequence-detector/)