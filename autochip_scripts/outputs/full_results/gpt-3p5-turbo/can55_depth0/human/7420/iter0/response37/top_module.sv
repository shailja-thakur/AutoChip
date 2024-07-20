module top_module(
	input [7:0] p1, 
	output p1y, 
	input [7:0] p2, 
	output p2y
);

// instantiate NAND gates
nand_gate g1(.p(p1), .y(p1y));
nand_gate g2(.p(p2), .y(p2y));

endmodule
