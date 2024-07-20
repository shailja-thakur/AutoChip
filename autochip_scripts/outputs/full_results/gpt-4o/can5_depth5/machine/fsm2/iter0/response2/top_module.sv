module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Declare state variables
	reg state, next_state;

	// State encoding
	localparam A = 1'b0, B = 1'b1;

	// Combinational block to determine the next state
	always @(*) begin
		case (state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
			default: next_state = A;
		endcase
	end

	// Clocked block to update current state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == B);
	end

endmodule
