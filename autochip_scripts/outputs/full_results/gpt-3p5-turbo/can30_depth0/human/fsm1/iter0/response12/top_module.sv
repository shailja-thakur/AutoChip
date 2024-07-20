module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define states
	parameter B = 0;
	parameter A = 1;

	reg [1:0] state; // state register

	always @(posedge clk or posedge areset)
		if (areset)
			state <= B; // reset state to B
		else
			case (state)
				B: state <= in ? B : A;
				A: state <= in ? A : B;
			endcase

	assign out = state; // output state

endmodule
