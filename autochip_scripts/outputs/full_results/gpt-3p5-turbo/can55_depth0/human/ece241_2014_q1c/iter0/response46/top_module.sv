module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	assign {overflow, s} = a + b;
endmodule
