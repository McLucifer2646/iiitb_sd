
#mapping to given library file
read_liberty -lib /home/anshul/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# read desig
read_verilog iiitb_seq_det_moore_fsm.v

# generic synthesis
synth -top Sequence_Detector_MOORE_Verilog

# mapping to mycells.lib
#dfflibmap -liberty /home/anshul/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/anshul/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
#flatten

# write synthesized design
write_verilog -noattr iiitb_sqd_synth.v