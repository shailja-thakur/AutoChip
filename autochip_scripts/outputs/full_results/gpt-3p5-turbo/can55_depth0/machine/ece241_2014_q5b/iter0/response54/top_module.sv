module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	reg state;
	
	always @(posedge clk or posedge areset)
		if (areset)
			state <= A;
		else
			case (state)
				A: if (x) state <= B; else state <= A;
				B: state <= B;
			endcase
	
	assign z = (state == A && x) || (state == B && !x);
	
endmodule
