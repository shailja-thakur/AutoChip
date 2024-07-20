module top_module(
	input [7:0] p1,
	output p1y,
	input [7:0] p2,
	output p2y
);

	// Internal wires
	wire nand1;
	wire nand2;

	// Connection to the first 4-input NAND gate
	assign nand1 = ~(p1[0] & p1[1] & p1[2] & p1[3]);

	// Connection to the second 4-input NAND gate
	assign nand2 = ~(p2[0] & p2[1] & p2[2] & p2[3]);

	// Output assignment
	assign p1y = nand1;
	assign p2y = nand2;

endmodule
