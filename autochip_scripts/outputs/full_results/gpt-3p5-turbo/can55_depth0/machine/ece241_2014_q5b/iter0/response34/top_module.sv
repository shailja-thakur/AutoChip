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
		if(areset)
			state <= A;
		else begin
			case(state)
				A: state <= (x == 1'b1) ? B : A;
				B: state <= B;
				default: state <= A;
			endcase
		end
	
	assign z = (state == A && x == 1'b1) || (state == B && x == 1'b0);
endmodule
