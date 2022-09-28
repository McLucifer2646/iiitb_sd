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

## Schematic of Sequence Detector using VIVADO

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/Schematic.png">
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

### Netlist representation

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


**The process of LAYOUT begins from here**

## Python Installation

```
$   sudo apt install -y build-essential python3 python3-venv python3-pip
```

## Docker Installation
```
$   sudo apt-get update

$   sudo apt-get install docker docker-compose

$   sudo systemctl start docker

$   sudo docker run hello-world
```

*If the docker is successfully installed u will get a success message here*

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/docker_success.png">
</p>

## OpenLANE Installation

OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

To run this design as per screenshots go to your design folder and perform the cloning process, else go to home directory and perform the commands nothing will change except the paths in the magic commandline.

```
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git

$   cd OpenLane/

$   make

$   make test
```

After 43 steps, if it ended with saying Basic test passed then open lane installed succesfully.

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/testpassed.png">
</p>

## Magic Installation

For Magic to be installed and for it to work properly the following softwares have to be installed first:
```
$   sudo apt-get install m4 

$   sudo apt-get install tcsh

$   sudo apt-get install csh

$   sudo apt-get install libx11-dev

$   sudo apt-get install tcl-dev tk-dev

$   sudo apt-get install libcairo2-dev

$   sudo apt-get install mesa-common-dev libglu1-mesa-dev

$   sudo apt-get install libncurses-dev
```

Installing Magic

```
$   git clone https://github.com/RTimothyEdwards/magic

$   cd magic

$   ./configure

$   make

$   make install
```

## Creating a Custom Inverter Cell

A Custom Inverter Cell is required to create an inverter that can be tweaked based on our requirements and locally used in our design files. 

Open Terminal in the folder you want to create a custom inverter cell and run the following commands.

```
$   git clone https://github.com/nickson-jose/vsdstdcelldesign.git

$   cd vsdstdcelldesign

$   cp ./libs/sky130A.tech sky130A.tech

$   magic -T sky130A.tech sky130_inv.mag &
```

Two windows pop up when we run the above magic command, The first window is the Magic Viewport and the second window is the TCL console. 

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/inverter.png">
</p>

The above layout can be seen in the magic viewport.The design can be verified here and different  layers can be seen and examined by selecting the area of examination and typeing ```what``` in the tcl window. 

To extract Spice netlist, Type the following commands in tcl window.
```
%   extract all

%   ext2spice cthresh 0 rthresh 0

%   ext2spice
```

*Note that the ```cthresh 0 rthresh 0``` are used to extract parasitic capacitances from the cell.*

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/console.png">
</p>

After this step,

The spice netlist has to be edited to add the libraries we are using. To edit the spice netlist navigate to the ```vsdstdcelldesign``` directory and look for ```sky130_inv.spice``` file and edit it as shown below. 

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/spice.png">
</p>


The final spice netlist should look like the following:
```
* SPICE3 file created from sky130_inv.ext - technology: sky130A

.option scale=0.01u
.include ./libs/pshort.lib
.include ./libs/nshort.lib


M1001 Y A VGND VGND nshort_model.0 ad=1435 pd=152 as=1365 ps=148 w=35 l=23
M1000 Y A VPWR VPWR pshort_model.0 ad=1443 pd=152 as=1517 ps=156 w=37 l=23
VDD VPWR 0 3.3V
VSS VGND 0 0V
Va A VGND PULSE(0V 3.3V 0 0.1ns 0.1ns 2ns 4ns)
C0 Y VPWR 0.08fF
C1 A Y 0.02fF
C2 A VPWR 0.08fF
C3 Y VGND 0.18fF
C4 VPWR VGND 0.74fF


.tran 1n 20n
.control
run
.endc
.end
```
Save the above editted file and install the ngspice tool using the following command:
```
$   sudo apt-get install ngspice
```
Next open the terminal in the directory where ngspice is stored and type the following command, ngspice console will open:

```
$   ngspice sky130_inv.spice 
```

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/ngspice.png">
</p>

Now you can plot the graphs for the designed inverter model. Type the following command in the ngspice console.

```
->  plot y vs time a
```

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/plot.png">
</p>

Four timing parameters are used to characterize the inverter standard cell:

1. Rise time: Time taken for the output to rise from 20% of max value to 80% of max value<br>
        `Rise time = (2.23843 - 2.17935) = 59.08ps`
2. Fall time- Time taken for the output to fall from 80% of max value to 20% of max value<br>
        `Fall time = (4.09291 - 4.05004) = 42.87ps`
3. Cell rise delay = time(50% output rise) - time(50% input fall)<br>
        `Cell rise delay = (2.20636 - 2.15) = 56.36ps`  
4. Cell fall delay  = time(50% output fall) - time(50% input rise)<br>
        `Cell fall delay = (4.07479 - 4.05) = 24.79ps`
        

To get a grid and to ensure the ports are placed correctly we can use this command in the tcl console

```
%   grid 0.46um 0.34um 0.23um 0.17um
```

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/inverter_grid.png">
</p>

To save the file with a different name, use the folllowing command in tcl window
```
%   save sky130_vsdinv.mag
```

Now open the sky130_vsdinv.mag using the magic command in terminal

```
$   magic -T sky130A.tech sky130_vsdinv.mag
```

In the tcl window type the following command to generate sky130_vsdinv.lef
```
%   lef write
```

*A new sky130_vsdinv.lef file be created in the current directory.*

## Layout

### Preparatory Steps
The layout for the design we have been working on can be created using OpenLANE. But before this we have to perform some preparatory steps to run our custom design in OpenLANE. Navigate to the openlane folder and run the following commands:

```
$   cd designs

$   mkdir iiitb_sd

$   cd iiitb_sd

$   touch config.json

$   mkdir src

$   cd src
```

Next copy ```iiitb_seq_det_moore_fsm.v```, ```sky130_fd_sc_hd__fast.lib```, ```sky130_fd_sc_hd__slow.lib```, ```sky130_fd_sc_hd__typical.lib``` and ```sky130_vsdinv.lef``` in the src folder. The ```iiitb_seq_det_moore_fsm.v``` should be copied from the main repository, and the whole layout procedure will be carried out on this RTL design file.

After this step your src folder should look like this:

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/src_folder.png">
</p>

Next we shall edit the ```cofig.json``` file

```
{
    "DESIGN_NAME": "Sequence_Detector_MOORE_Verilog",
    "VERILOG_FILES": "dir::src/iiitb_seq_det_moore_fsm.v",
    "CLOCK_PORT": "clock",
    "CLOCK_NET": "clock",
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 6,
    "PL_TARGET_DENSITY": 0.5,
    "FP_SIZING" : "relative",
    "pdk::sky130*": {
        "FP_CORE_UTIL": 5,
        "scl::sky130_fd_sc_hd": {
            "FP_CORE_UTIL": 5
        }
    },
    
    "LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
    "LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
    "LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
    "LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",  
    "TEST_EXTERNAL_GLOB": "dir::../iiitb_sd/src/*",
    "SYNTH_DRIVING_CELL":"sky130_vsdinv"

}
```

In this file the ```DESIGN_NAME``` corresponds to the **name of the module** in your design file also note to change the ```CLOCK_PORT``` and ```CLOCK_NET``` variables as per clock used in your design file.

### Errors in config.json

Now the major part where I encountered a lot of errors was tweaking values in .json file based on the design files.

**Mostly occurs in floorplan**
```
1) [ERROR PDN-0175] Pitch 5.04050 is too small for, must be atleast 6.6000
```
For these type of errors just try decreasing the values of: <br>
```PL_TARGET_DENSITY``` to 0.6 or 0.5 <br>
```FP_CORE_UTIL``` to half the current value and run the synthesis again <br>

**Mostly occurs in placement**

```
2) [ERROR GPL-0306] RePlAce diverged at wire/density gradient Sum.
```

For these type of errors : <br>
We can observe the ```worst slack``` value in red color and trying to bring it to a minimal value tending to zero will help us solve this error. This value can be fixed by reducing the ```CLOCK_PERIOD``` in .json file.



Save all the changes made above and navigate to the OpenLane folder in terminal and run the following command :
```
$   sudo make mount
```

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/mount.png">
</p>

After entering the openlane container give the following command for a step by step procedure:

```
$   ./flow.tcl -interactive
```

This command will open the tcl console. In the tcl console type the following commands:
```
%   package require openlane 0.9

%   prep -design iiitb_sd
```
The following commands are to merge the external lef files to the merged.nom.lef. In our case ```sky130_vsdiat.lef``` is the external .lef file that gets merged to the lef file.

```
%   set lefs [glob $::env(DESIGN_DIR)/src/*.lef]

%   add_lefs -src $lefs
```

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/container.png">
</p>

After the merging step the contents of the merged.nom.lef file should contain the Macro definition of sky130_vsdinv

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/vsdinv1.png">
</p>


### Synthesis

```
%   run_synthesis
```
<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/run_synthesis.png">
</p>

#### Synthesis Report

Details of the gates used

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/gates.png">
</p>

Setup and Hold Slack after synthesis

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/synth_vcd.png">
</p>

**The sky130_vsdinv should also reflect in your netlist after Synthesis**
<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/synth_vsd1.png">
</p>

### Floorplan

```
%   run_floorplan
```
<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/floorplan.png">
</p>

#### Floorplan Report

**Die Area**:

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/die_area.png">
</p>

**Core Area**:

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/core_area.png">
</p>

Navigate to results -> floorplan and type the Magic command in terminal to open the floorplan
```
magic -T /home/anshul/Documents/iiitb_sd/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.nom.lef def read Sequence_Detector_MOORE_Verilog.def &
```

#### Floorplan view

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/floorplan_1.png">
</p>

Zoomed in view of Stacked components before placement.

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/floorplan_2.png">
</p>

### Placement

```
%   run_placement
```
<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/placement.png">
</p>

#### Placement Report

Navigate to results->placement and type the Magic command in terminal to open the placement view

```
magic -T /home/anshul/Documents/iiitb_sd/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.nom.lef def read Sequence_Detector_MOORE_Verilog.def &
```

#### Placement view

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/placement_1.png">
</p>

We can also locate the sky130_vsdinv in this view:

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/placement_2.png">
</p>

**The sky130_vsdinv should also reflect in your netlist after placement**
<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/placement_vsd.png">
</p>

### Clock Tree Synthesis

```
%   run_cts
```
<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/cts_1234.png">
</p>

#### Timing analysis
<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/cts_1.png">
</p>

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/cts.png">
</p>

### Routing

```
%   run_routing
```

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/routing.png">
</p>

#### Routing Report

Navigate to results->routing and type the Magic command in terminal to open the placement view

```
magic -T /home/anshul/Documents/iiitb_sd/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.nom.lef def read Sequence_Detector_MOORE_Verilog.def &
```

#### Routing view

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/routing_1.png">
</p>

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/routing_111.png">
</p>

**Area report by magic :**

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/routing_area.png">
</p>

**The sky130_vsdinv should also reflect in your netlist after routing**
<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/routing_2.png">
</p>

## Results Post-Layout

### 1. Post Layout synthesis gate count

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/gate_count.png">
</p>

**Gate Count = 14**

### 2. Area (box command)

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/Area.png">
</p>

**Area = 4878.272 um^2**

### 3. Performance

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/Performance_1.png">
</p>

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/Performance_2.png">
</p>

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/Performance_3.png">
</p>

**Performance = 1/(clock period - slack) = 1/(6 - 3.78)ns = 470.45 MHz**

### 4. Flop/(Standard Cell Ratio)

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/Ratio.png">
</p>


**Flop Ratio = Ratio of total number of flip flops / Total number of cells present in the design = 3/14 = 0.214**

### 5. Power (Internal, Switching, Leakage and Total)

<p align="center">
  <img src="https://github.com/McLucifer2646/iiitb_sd/blob/main/Images/PowerReport.png">
</p>

<pre>
**Internal Power  = 1.08e-04 (85.4%)**

**Switching Power = 1.84e-05 (14.6%)**

**Leakage Power   = 2.65e-10 (0.0%)**

**Total Power     = 1.26e-04 (100%)**
</pre>

## Author 

- **Anshul Madurwar** 


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
