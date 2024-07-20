module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	parameter A = 1'b0, B = 1'b1;
	reg state, next_state;

	// Combinational logic block to determine the next state
	always @(*) begin
		case (state)
			A: if (in) next_state = A; else next_state = B;
			B: if (in) next_state = B; else next_state = A;
			default: next_state = B; // Default to initial state B
		endcase
	end

	// Sequential logic block to update the state
	always @(posedge clk) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			out <= 1'b1;  // Reset output to initial state value `B`
		else
			out <= (next_state == B) ? 1'b1 : 1'b0;
	end
endmodule
