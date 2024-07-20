module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Define states
	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;
	
	// Declare state register and next state wires
	reg [1:0] state, next_state;
	
	// Declare done register
	reg done_reg;
	
	// Assign initial state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= BYTE1;
		else
			state <= next_state;
	end
	
	// Assign next state based on current state
	always @(state, in) begin
		case (state)
			BYTE1: begin
				if (in[2] == 1)
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: begin
				if (in[2] == 1)
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
		endcase
	end
	
	// Assign done output based on current state
	assign done = (state == DONE);
	
	// Done signal synchronization
	always @(posedge clk) begin
		done_reg <= done;
	end
	
endmodule
