module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	// Internal signals
	wire nand1_out, nand2_out;

	// Instantiate NAND gates
	nand nand1(.p1(p1a), .p2(p1b), .p3(p1c), .p4(p1d), .y(nand1_out));
	nand nand2(.p1(p2a), .p2(p2b), .p3(p2c), .p4(p2d), .y(nand2_out));

	// Assign outputs
	assign p1y = nand1_out;
	assign p2y = nand2_out;

endmodule
module nand(
	input p1,
	input p2,
	input p3,
	input p4,
	output y
);
	assign y = ~(p1 & p2 & p3 & p4);

endmodule
