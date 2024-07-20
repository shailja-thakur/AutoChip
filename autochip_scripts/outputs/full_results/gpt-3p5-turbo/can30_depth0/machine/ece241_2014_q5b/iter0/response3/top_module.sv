module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	parameter A = 0;
	parameter B = 1;
	reg [1:0] state;
	
	always @(posedge clk or negedge areset)
		if (areset == 0)
			state <= A;
		else
			// case statement to determine next state
			case(state)
				A: if (x == 1)
					 state <= B;
				   else
					 state <= A;
				B: state <= B;
			endcase
	
	// set output based on state and x input
	assign z = (state == A && x == 1) || (state == B && x == 0);

endmodule
