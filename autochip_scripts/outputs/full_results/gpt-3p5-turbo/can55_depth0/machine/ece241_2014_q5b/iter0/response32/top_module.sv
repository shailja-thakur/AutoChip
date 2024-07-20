module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	parameter A = 0;
	parameter B = 1;

	reg [1:0] state;

	always @(posedge clk or posedge areset)
		if (areset)
			state <= A;
		else
			case (state)
				A: if (x == 1)
						state <= B;
				   else
				   		state <= A;
				B: state <= B;
			endcase

	assign z = (state == A && x == 1) || (state == B && x == 0);

endmodule
