module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	parameter A = 1'b0, B = 1'b1;
	reg state, next_state;

	// Next state logic
	always @(*) begin
		case (state)
			A: if (x == 1) next_state = B; else next_state = A;
			B: next_state = B;
			default: next_state = A;
		endcase
	end

	// State register with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		if ((state == A && x == 1) || (state == B && x == 0))
			z = 1;
		else
			z = 0;
	end
	
endmodule
