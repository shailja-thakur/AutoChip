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
	wire [3:0] n1_in;
	assign n1_in = {p1a, p1b, p1c, p1d};
	wire n1_out;
	assign n1_out = ~(n1_in[0] & n1_in[1] & n1_in[2] & n1_in[3]);

	// Second NAND gate
	wire [3:0] n2_in;
	assign n2_in = {p2a, p2b, p2c, p2d};
	wire n2_out;
	assign n2_out = ~(n2_in[0] & n2_in[1] & n2_in[2] & n2_in[3]);

	// Output assignments
	assign p1y = n1_out;
	assign p2y = n2_out;

endmodule
