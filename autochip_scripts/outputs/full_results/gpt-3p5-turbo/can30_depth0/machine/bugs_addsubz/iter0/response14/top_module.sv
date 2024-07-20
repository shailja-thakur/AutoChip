module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(a, b, do_sub)
		case(do_sub)
			0: out = a + b;
			   if (out == 0)
			   	  result_is_zero = 1;
			   else
			   	  result_is_zero = 0;
			1: out = a - b;
			   if (out == 0)
			   	  result_is_zero = 1;
			   else
			   	  result_is_zero = 0;
		endcase

endmodule
