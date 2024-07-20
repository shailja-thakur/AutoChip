module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	localparam A = 1'b0, B = 1'b1;

	// State registers
	reg state, next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A; // Default to state A for safety
		endcase
	end

	// Sequential logic to update state
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= A; // Reset state to A
		else
			state <= next_state; // Update state
	end

	// Output logic
	always @(*) begin
		if (state == B)
			out = 1'b1;
		else
			out = 1'b0;
	end

endmodule
