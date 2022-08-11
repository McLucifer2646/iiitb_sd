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

### Functional Simulation
To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.
```
$   sudo apt install -y git
$   git clone https://github.com/McLucifer2646/iiitb_physical_design_of_asics.git
$   cd iiitb_physical_design_of_asics
$   iverilog iiitb_seq_det_moore_fsm.v iiitb_seq_det_moore_fsm_tb.v
$   ./a.out
$   gtkwave seq_det.vcd
```

## Functional Characteristics
In this simultion result we observe three waveform namely Clock(clk), Sequence Input and Detected Output. We also observe that around 160ns the Detector displays a HIGH signal indicating that the given sequence of '1111' was detected succesfully.

<p align="center">
  <img width="800" height="300" src="/Images/IMG2.jpg">
</p>


## Synthesis of verilog code (WORK IN PROGRESS)

#### About Yosys
Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains.

- more at https://yosyshq.net/yosys/

To install yosys follow the instructions in  this github repository

https://github.com/YosysHQ/yosys

- note: Identify the .lib file path in cloned folder and change the path in highlighted text to indentified path

*Note: To be further updated in future classes.*

#### to synthesize
```
$   yosys
$   yosys>    script yosys_run.sh
```

#### to see diffarent types of cells after synthesys
```
$   yosys>    stat
```
#### to generate schematics
```
$   yosys>    show
```


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
- [Applications](https://whomadewhat.org/what-are-applications-of-sequence-detector/)