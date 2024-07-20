module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(do_sub or a or b)
		case (do_sub)
			0: out = a + b;
			1: out = a - b;
		endcase

	always @(out)
		result_is_zero = (out == 8'b0);

endmodule
