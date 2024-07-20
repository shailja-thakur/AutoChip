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

	// Define internal wires
	wire a, b, c, d;
	wire y1, y2;

	// Instantiate two 4-input NAND gates
	nand_gate g1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(y1));
	nand_gate g2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(y2));

	// Assign the outputs of the NAND gates to the module outputs
	assign p1y = y1;
	assign p2y = y2;

endmodule
module nand_gate(
	input a,
	input b,
	input c,
	input d,
	output y
);
	nand n1(.a(a), .b(b), .y(ny1));
	nand n2(.a(c), .b(d), .y(ny2));
	nand n3(.a(ny1), .b(ny2), .y(y));

endmodule
module nand(
	input a,
	input b,
	output y
);
	assign y = ~(a & b);

endmodule
