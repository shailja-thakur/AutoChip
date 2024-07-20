module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define state parameters
	parameter A = 1'b0, B = 1'b1;

	// State register
	reg state, next_state;

	// Asynchronous reset and state transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: if (x)
					next_state = B;
				else
					next_state = A;
			B: next_state = B;
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (areset)
			z <= 1'b0; // Clear output on reset
		else if (state == A && x)
			z <= 1'b1;
		else if (state == B && !x)
			z <= 1'b1;
		else
			z <= 1'b0;
	end

endmodule
