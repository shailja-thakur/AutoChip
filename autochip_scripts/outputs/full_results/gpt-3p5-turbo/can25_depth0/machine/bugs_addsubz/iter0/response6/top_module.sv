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
			   result_is_zero = (out == 0);
			1: out = a - b;
			   result_is_zero = (out == 0);
			default: out = 0;
			   result_is_zero = 0;
		endcase

endmodule
