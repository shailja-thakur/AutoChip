module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define parameters for state encoding
	parameter A = 1'b0, B = 1'b1;

	// Declare state register
	reg state, next_state;

	// Combinational logic block to determine the next state
	always @(*) begin
		case (state)
			A: next_state = (in) ? A : B;
			B: next_state = (in) ? B : A;
			default: next_state = B; // default to B for safety
		endcase
	end

	// Sequential logic block triggered on the rising edge of clk or reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset state to B
		else
			state <= next_state;
	end

	// Output logic: out is high when in state B, low otherwise
	always @(posedge clk) begin
		out <= (state == B);
	end

endmodule
