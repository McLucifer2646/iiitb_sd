// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for Sequence Detector using Moore FSM
// The sequence being detected is "1011" or One Zero One One 
module Sequence_Detector_MOORE_Verilog(sequence_in,clock,reset,detector_out);
input clock; 			// clock signal
input reset; 			// reset input
input sequence_in; 		// binary input
output reg detector_out; 		// output of the sequence detector
parameter
	Zero = 3'b000, 						// "Zero" State
  	One = 3'b001, 						// "One" State
  	OneOne = 3'b011, 					// "OneOne" State
  	OneOneOne = 3'b010, 				// "OneOneOne" State
  	OneOneOneOne = 3'b110;				// "OneOneOneOne" State
reg [2:0] current_state, next_state; 	// current state and next state
// sequential memory of the Moore FSM
always @(posedge clock, posedge reset)
begin
 	if(reset==1) 
 		current_state <= Zero;			// when reset=1, reset the state of the FSM to "Zero" State
 	else
 		current_state <= next_state; 	// otherwise, next state
end

// combinational logic of the Moore FSM
// to determine next state 
always @(current_state,sequence_in)
begin
 	case(current_state) 
 	Zero:begin
 	 	if(sequence_in == 1)
 	 	 	next_state = One;
 	 	else
 	 	 	next_state = Zero;
 	end
 	One:begin
 	 	if(sequence_in == 1)
 	 	 	next_state = OneOne;
 	 	else
 	 	 	next_state = Zero;
 	end
 	OneOne:begin
 	 	if(sequence_in == 1)
 	 	 	next_state = OneOneOne;
 	 	else
 	 	 	next_state = Zero;
 	end 
 	OneOneOne:begin
 	 	if(sequence_in == 1)
 	 	 	next_state = OneOneOneOne;
 	 	else
 	 	 	next_state = Zero;
 	end
 	OneOneOneOne:begin
 	 	if(sequence_in == 0)
 	 	 	next_state = Zero;
 	 	else
 	 	 	next_state = OneOneOneOne;
 	end
 	default:next_state = Zero;
 	endcase
end
// combinational logic to determine the output
// of the Moore FSM, output only depends on current state
always @(current_state)
begin 
 case(current_state) 
 Zero:   detector_out = 0;
 One:   detector_out = 0;
 OneOne:  detector_out = 0;
 OneOneOne:  detector_out = 0;
 OneOneOneOne:  detector_out = 1;
 default:  detector_out = 0;
 endcase
end 
endmodule