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

	// internal wires
	wire nand1_out;
	wire nand2_out;

	// NAND gates
	nand_4_input u1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_out));
	nand_4_input u2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_out));

	// output assignments
	assign p1y = nand1_out;
	assign p2y = nand2_out;

endmodule
module nand_4_input(
	input a,
	input b,
	input c,
	input d,
	output y
);
	nand u1(.a(a), .b(b), .z(temp1));
	nand u2(.a(c), .b(d), .z(temp2));
	nand u3(.a(temp1), .b(temp2), .z(y));

	wire temp1;
	wire temp2;

endmodule
module nand(
	input a,
	input b,
	output z
);
	assign z = ~(a & b);

endmodule
