module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define state parameters
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	// State register
	reg state, next_state;

	// Combinational logic to determine the next state
	always @(*) begin
		case (state)
			A: if (in)
				next_state = A;
			   else
				next_state = B;
			B: if (in)
				next_state = B;
			   else
				next_state = A;
			default: next_state = A; // Default state
		endcase
	end

	// Update state on the rising edge of the clock
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Initial state
		else
			state <= next_state;
	end
	
	// Output logic
	always @(state) begin
		if (state == B)
			out = 1'b1;
		else
			out = 1'b0;
	end
	
endmodule
