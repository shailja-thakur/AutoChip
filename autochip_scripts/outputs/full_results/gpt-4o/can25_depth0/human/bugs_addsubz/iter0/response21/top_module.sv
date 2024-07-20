module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(*) begin
		case (do_sub)
			0: out = a + b;
			1: out = a - b;
		endcase

		if (~|out) // Use bitwise reduction OR operator to check if all bits of out are zero
			result_is_zero = 1;
		else
			result_is_zero = 0;
	end

endmodule
