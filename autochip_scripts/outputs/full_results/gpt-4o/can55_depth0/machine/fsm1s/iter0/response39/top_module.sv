module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	parameter A = 1'b0, B = 1'b1;

	// Current state register
	reg state, next_state;

	// Combinational logic for next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = A;  // Default state to handle unexpected cases
		endcase
	end

	// Sequential logic for state transition and reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(state) begin
		out = (state == B);
	end

endmodule
