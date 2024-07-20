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
	
	// Define internal wire signals
	wire nand1_out;
	wire nand2_out;
	
	// Instantiate NAND gates
	nand_gate nand1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_out));
	nand_gate nand2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_out));
	
	// Bitwise not gate for the first output
	not_gate not1(.a(nand1_out), .y(p1y));
	
	// Bitwise not gate for the second output
	not_gate not2(.a(nand2_out), .y(p2y));
	
	// Define NAND gate module
	module nand_gate(
		input a,
		input b,
		input c,
		input d,
		output y
	);
	
		assign y = ~( a & b & c & d );
	
	endmodule
module not_gate(
		input a,
		output y
	);
	
		assign y = ~a;
	
	endmodule
