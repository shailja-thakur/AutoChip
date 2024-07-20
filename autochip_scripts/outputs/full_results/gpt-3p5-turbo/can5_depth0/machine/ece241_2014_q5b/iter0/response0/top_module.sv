module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	parameter A = 0;
	parameter B = 1;
	reg [1:0] state;
	reg z;

	always @(posedge clk or negedge areset)
	begin
		if (areset == 0)
			state <= A;
		else
			case (state)
				A: if (x == 1)
						state <= B;
				   else
				   		state <= A;
				B: state <= B;
			endcase
	end

	always @*
	begin
		if (state == A && x == 1)
			z = 1;
		else if (state == B && x == 0)
			z = 1;
		else
			z = 0;
	end
endmodule
