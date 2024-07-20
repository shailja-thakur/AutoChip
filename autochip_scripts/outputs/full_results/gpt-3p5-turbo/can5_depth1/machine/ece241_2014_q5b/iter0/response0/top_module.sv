module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	parameter A = 1'b0;
	parameter B = 1'b1;
	reg state;

	always @(posedge clk) begin
		if (areset)
			state <= A;
		else begin
			case(state)
				A: state <= (x == 1'b1) ? B : A;
				B: state <= B;
			endcase
		end
	end

	always @(state, x) begin
		if (state == A && x == 1'b1)
			z <= 1'b1;
		else if (state == B && x == 1'b0)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
endmodule
