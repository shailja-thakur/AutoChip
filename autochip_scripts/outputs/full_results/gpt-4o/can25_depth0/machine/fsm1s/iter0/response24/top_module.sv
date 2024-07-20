module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	parameter A = 1'b0;
	parameter B = 1'b1;

	// State register
	reg state, next_state;

	// Combinational logic block to determine next state
	always @(*) begin
		case (state)
			A: next_state = (in) ? A : B;
			B: next_state = (in) ? B : A;
			default: next_state = B; // Default to state B for safety
		endcase
	end

	// Sequential logic block to update state register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset to initial state B
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == B) ? 1'b1 : 1'b0;
		end
endmodule
