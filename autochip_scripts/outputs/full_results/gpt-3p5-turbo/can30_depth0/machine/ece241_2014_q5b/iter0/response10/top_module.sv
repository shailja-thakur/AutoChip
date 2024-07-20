module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	parameter A = 1;
	parameter B = 2;

	reg [1:0] state;
	
	always @(posedge clk or negedge areset)
		begin
			if (!areset)
				state <= A;
			else
				case (state)
					A: if (x) state <= B;
					   else state <= A;
					B: state <= B;
				endcase
		end
			
	assign z = ((state == A) && x) || ((state == B) && (!x));
	
endmodule
