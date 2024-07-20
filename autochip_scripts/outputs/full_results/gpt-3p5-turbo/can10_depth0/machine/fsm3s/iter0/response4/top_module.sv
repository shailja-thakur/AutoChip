module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define the 4 states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define the state register
	reg [1:0] state;
	
	// Define the next state variable
	reg [1:0] next_state;
	
	// Assign initial state to A
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Define the next state logic
	always @(state or in) begin
		case (state)
			A: if (in) next_state = B; else next_state = A;
			B: if (in) next_state = B; else next_state = C;
			C: if (in) next_state = D; else next_state = A;
			D: if (in) next_state = B; else next_state = C;
		endcase
	end
	
	// Output logic
	always @(state) begin
		if (state == D)
			out = 1'b1;
		else
			out = 1'b0;
	end
	
endmodule
