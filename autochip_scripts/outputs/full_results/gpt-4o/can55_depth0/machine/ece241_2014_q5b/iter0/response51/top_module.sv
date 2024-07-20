module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	parameter A = 1'b0;
	parameter B = 1'b1;

	// State register
	reg state, next_state;

	// Sequential logic (state transition)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;  // Asynchronous reset
		else
			state <= next_state;  // State transition
	end

	// Combinational logic (next state logic)
	always @(*) begin
		case (state)
			A: next_state = x ? B : A;
			B: next_state = B;
			default: next_state = A;  // Default state
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			A: z = x ? 1'b1 : 1'b0;
			B: z = x ? 1'b0 : 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
