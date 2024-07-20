module top_module (
	input [7:0] a,
	input [7:0] b,
	output reg signed [7:0] s,
	output reg overflow
);
	always @(*)
	begin
		s = a + b;
		overflow = (s[7] != a[7] && s[7] != b[7]);
	end
endmodule
