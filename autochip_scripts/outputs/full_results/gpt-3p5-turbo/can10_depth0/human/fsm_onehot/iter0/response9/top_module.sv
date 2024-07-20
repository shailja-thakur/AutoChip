module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// Output wires
	wire [9:0] next_state;
	wire out1;
	wire out2;
	
	// Assign next state and outputs based on current state and input
	assign next_state = getNextState(state, in);
	assign {out1, out2} = getOutputs(state);
	
	// Define the state transition and output logic
	function [9:0] getNextState;
		input [9:0] state;
		input in;
		reg [9:0] next_state;
		
		begin
			case (state)
				10'b01_000_000: if (in) next_state = 10'b00_000_001;
				                 else next_state = 10'b01_001_000;
				10'b01_001_000: if (in) next_state = 10'b10_010_000;
				                 else next_state = 10'b01_011_000;
				10'b10_010_000: if (in) next_state = 10'b00_000_010;
				                 else next_state = 10'b10_001_000;
				10'b10_001_000: if (in) next_state = 10'b01_000_000;
				                 else next_state = 10'b10_011_000;
				10'b10_011_000: if (in) next_state = 10'b10_100_000;
				                 else next_state = 10'b11_000_000;
				10'b10_100_000: if (in) next_state = 10'b00_000_011;
				                 else next_state = 10'b01_001_000;
				10'b11_000_000: if (in) next_state = 10'b00_000_001;
				                 else next_state = 10'b01_001_000;
				10'b00_000_001: if (in) next_state = 10'b10_010_000;
				                 else next_state = 10'b01_011_000;
				10'b01_011_000: if (in) next_state = 10'b10_001_000;
				                 else next_state = 10'b10_011_000;
				10'b10_001_000: if (in) next_state = 10'b01_000_000;
				                 else next_state = 10'b10_011_000;
			endcase
			
			getNextState = next_state;
		end
	endfunction
	
	function [1:0] getOutputs;
		input [9:0] state;
		wire [1:0] outputs;
		
		begin
			case (state)
				10'b00_000_000: outputs = 2'b00;
				10'b01_000_000: outputs = 2'b00;
				10'b10_010_000: outputs = 2'b00;
				10'b01_001_000: outputs = 2'b00;
				10'b10_011_000: outputs = 2'b00;
				10'b10_100_000: outputs = 2'b00;
				10'b00_000_011: outputs = 2'b00;
				10'b11_000_000: outputs = 2'b01;
				10'b00_000_001: outputs = 2'b00;
				10'b01_011_000: outputs = 2'b00;
				10'b10_001_000: outputs = 2'b00;
			endcase
			
			getOutputs = outputs;
		end
	endfunction

endmodule
