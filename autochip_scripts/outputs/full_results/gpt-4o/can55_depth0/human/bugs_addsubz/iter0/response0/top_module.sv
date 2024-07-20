module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(*) begin
		if (do_sub)
			out = a - b;
		else
			out = a + b;

		// Correctly set the result_is_zero flag
		if (out == 8'b0)
			result_is_zero = 1;
		else
			result_is_zero = 0;
	end

endmodule
