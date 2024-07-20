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
	wire [3:0] n1_out;
	assign n1_out = ~(p1a & p1b & p1c & p1d);

	// Second NAND gate
	wire [3:0] n2_out;
	assign n2_out = ~(p2a & p2b & p2c & p2d);

	// Output assignments
	assign p1y = n1_out[0];
	assign p2y = n2_out[0:0];

endmodule
