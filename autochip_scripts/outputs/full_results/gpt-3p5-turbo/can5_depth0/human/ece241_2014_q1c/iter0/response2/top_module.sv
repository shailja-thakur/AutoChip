module top_module (
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] s,
	output reg overflow
);

	always @(*) begin
		s = a + b;
		if (((a[7] == 1 && b[7] == 1 && s[7] == 0) || (a[7] == 0 && b[7] == 0 && s[7] == 1)))
			overflow = 1;
		else
			overflow = 0;
	end

endmodule
