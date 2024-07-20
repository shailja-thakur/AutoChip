module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg signed [8:0] result;

	always @ (*)
	begin
		result = a + b;

		if (result > 127 || result < -128)
			overflow = 1;
		else
			overflow = 0;

		s = result[7:0];
	end

endmodule
