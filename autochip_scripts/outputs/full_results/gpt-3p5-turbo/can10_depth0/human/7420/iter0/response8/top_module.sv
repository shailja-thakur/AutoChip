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
	// Internal wires
	wire [3:0] nand1_out;
	wire [3:0] nand2_out;
	wire nand_out_y1;
	wire nand_out_y2;
	
	// Instantiate NAND gates
	nand4_gate nand1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_out));
	nand4_gate nand2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_out));
	nand2_gate nand_y1(.a(nand1_out), .b(nand2_out), .y(nand_out_y1));
	nand2_gate nand_y2(.a(nand1_out), .b(nand2_out), .y(nand_out_y2));
	
	assign p1y = nand_out_y1;
	assign p2y = nand_out_y2;
	
endmodule
module nand2_gate(
	input a,
	input b,
	output y
);
	assign y = !(a & b);
endmodule
module nand4_gate(
	input [3:0] a,
	input [3:0] b,
	input [3:0] c,
	input [3:0] d,
	output [3:0] y
);
	assign y = ~(a & b & c & d);
endmodule
