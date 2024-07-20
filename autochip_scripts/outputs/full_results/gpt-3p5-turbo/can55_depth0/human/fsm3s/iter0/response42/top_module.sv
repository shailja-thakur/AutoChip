module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	// Define states as parameters
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define internal state and next state registers
	reg [1:0] state, next_state;
	
	// Define output register
	reg out_reg;
	
	// Moore output logic
	always @(state)
		case (state)
			A: out_reg = 1'b0;
			B: out_reg = 1'b0;
			C: out_reg = 1'b0;
			D: out_reg = 1'b1;
		endcase
	
	// State transition logic
	always @(posedge clk, posedge reset)
		if (reset)
			state <= A;
		else
			state <= next_state;
			
	always @*
		case (state)
			A: if (in) next_state = B; else next_state = A;
			B: if (in) next_state = B; else next_state = C;
			C: if (in) next_state = D; else next_state = A;
			D: if (in) next_state = B; else next_state = C;
		endcase
	
	assign out = out_reg;
endmodule
