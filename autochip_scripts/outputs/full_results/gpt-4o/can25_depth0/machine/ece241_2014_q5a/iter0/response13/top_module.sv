module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	// Define parameters for states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;

	// Define state register
	reg [1:0] state, next_state;

	// Determine next state
	always @(*) begin
		case (state)
			A: if (x)
				next_state = C;
			   else
				next_state = A;
			B: if (x)
				next_state = B;
			   else
				next_state = C;
			C: if (x)
				next_state = B;
			   else
				next_state = C;
			default: next_state = A;
		endcase
	end

	// Update state on clock or reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Determine output z
	always @(*) begin
		if (state == C)
			z = 1;
		else
			z = 0;
	end
endmodule
