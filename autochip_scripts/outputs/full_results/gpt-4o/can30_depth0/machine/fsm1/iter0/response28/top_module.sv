module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	reg state, next_state;
	parameter A = 1'b0, B = 1'b1;

	// State transition logic
	always @(*) begin
		case (state)
			A: if (in) next_state = A; else next_state = B;
			B: if (in) next_state = B; else next_state = A;
			default: next_state = B;  // Default state as B
		endcase
	end

	// State update logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
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
