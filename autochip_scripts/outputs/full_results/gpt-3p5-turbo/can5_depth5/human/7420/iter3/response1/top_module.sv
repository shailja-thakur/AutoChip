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
	wire n1_a, n1_b, n1_c, n1_d;
	wire n1_out;

	assign n1_a = p1a[0];
	assign n1_b = p1b[0];
	assign n1_c = p1c[0];
	assign n1_d = p1d[0];

	nand(n1_out, n1_a, n1_b, n1_c, n1_d);

	// Second NAND gate
	wire n2_a, n2_b, n2_c, n2_d;
	wire n2_out;

	assign n2_a = p2a[0];
	assign n2_b = p2b[0];
	assign n2_c = p2c[0];
	assign n2_d = p2d[0];

	nand(n2_out, n2_a, n2_b, n2_c, n2_d);

	// Output assignments
	assign p1y = n1_out;
	assign p2y = n2_out;

endmodule
