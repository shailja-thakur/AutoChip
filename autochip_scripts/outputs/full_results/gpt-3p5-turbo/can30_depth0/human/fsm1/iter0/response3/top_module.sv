module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	parameter B = 1'b0;
	parameter A = 1'b1;

	reg state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else if (state == B)
			state <= (in) ? B : A;
		else if (state == A)
			state <= (in) ? A : B;
	end

	always @(state) begin
		case (state)
			B: out = 1'b0;
			A: out = 1'b1;
		endcase
	end

endmodule
