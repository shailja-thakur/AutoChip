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

	// Internal wires for connecting gates
	wire n1, n2, n3, n4, n5;

	// 4-input NAND gates
	nandgate(n1, p1a, p1b, p1c, p1d);
	nandgate(n2, p2a, p2b, p2c, p2d);

	// Connect output of NAND gates to outputs
	assign p1y = n1;
	assign p2y = n2;

	// 4-input NAND gate implementation
	// ref: https://www.verilogpro.com/verilog-2001-constructs/

	module nandgate(output n, input a, input b, input c, input d);
		wire w1, w2, w3;

		assign w1 = a & b;
		assign w2 = c & d;
		assign w3 = w1 & w2;

		assign n = ~w3;
	endmodule
