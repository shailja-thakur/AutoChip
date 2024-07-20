module top_module(
	input [3:0] p1a, 
	input [3:0] p1b, 
	input [3:0] p1c, 
	input [3:0] p1d, 
	output p1y, 
	input [3:0] p2a, 
	input [3:0] p2b, 
	input [3:0] p2c, 
	input [3:0] p2d, 
	output p2y
);
	// First NAND gate
	wire n1_out;
	assign n1_out = ~(p1a[0] & p1b[0] & p1c[0] & p1d[0]);

	// Second NAND gate
	wire n2_out;
	assign n2_out = ~(p2a[0] & p2b[0] & p2c[0] & p2d[0]);

	// Output assignments
	assign p1y = n1_out;
	assign p2y = n2_out;

endmodule
