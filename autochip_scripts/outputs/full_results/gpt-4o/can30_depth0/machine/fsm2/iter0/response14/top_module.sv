module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	reg state, next_state;
	localparam A = 1'b0, B = 1'b1;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
			default: next_state = A; // Default state
		endcase
	end

	// Sequential logic to update the current state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Reset to state A
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == B) ? 1'b1 : 1'b0;
	end

endmodule
