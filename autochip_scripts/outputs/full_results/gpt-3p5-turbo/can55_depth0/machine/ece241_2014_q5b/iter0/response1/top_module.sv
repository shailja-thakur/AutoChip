module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	parameter A = 1'b0;
	parameter B = 1'b1;

	reg state;

	always @(posedge clk or negedge areset)
		if (areset == 1'b0)
			state <= A;
		else
			case (state)
				A: if (x == 1'b1)
						state <= B;
					else
						state <= A;
				B: state <= B;
			endcase
	
	assign z = ((state == A) && (x == 1'b1)) || ((state == B) && (x == 1'b0));
	
endmodule
