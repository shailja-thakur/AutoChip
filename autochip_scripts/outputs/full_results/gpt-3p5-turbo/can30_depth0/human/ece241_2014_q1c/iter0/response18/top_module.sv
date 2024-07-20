module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] s_temp;
	reg overflow_temp;

	always @* begin
		s_temp = a + b;
		overflow_temp = (a[7] == b[7] && s_temp[7] != a[7]) ? 1 : 0;
	end

	assign s = s_temp;
	assign overflow = overflow_temp;

endmodule
