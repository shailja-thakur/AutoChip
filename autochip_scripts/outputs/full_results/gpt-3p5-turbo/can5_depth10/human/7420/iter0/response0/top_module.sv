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
	// Define internal wires and intermediate signals
	wire nand1_out, nand2_out;

	// Instantiate the NAND gates
	nand_gate nand1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_out));
	nand_gate nand2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_out));

	// Output connections
	assign p1y = nand1_out;
	assign p2y = nand2_out;

	// Define the NAND gate module
	module nand_gate(
		input a,
		input b,
		input c,
		input d,
		output y
	);
		// Internal wires and intermediate signals
		wire nand1_a, nand1_b, nand2_a, nand2_b, internal_out;

		// Instantiate the internal NAND gates
		nand internal_nand1(.a(a), .b(b), .y(nand1_a));
		nand internal_nand2(.a(c), .b(d), .y(nand1_b));
		nand internal_nand3(.a(nand1_a), .b(nand1_b), .y(nand2_a));
		nand internal_nand4(.a(a), .b(b), .y(nand2_b));

		// Final NAND gate and output connection
		nand final_nand(.a(nand2_a), .b(nand2_b), .y(internal_out));
		assign y = internal_out;

	endmodule
module nand(
		input a,
		input b,
		output y
	);
		// Internal wires and intermediate signals
		wire nand1_out;

		// NAND gate implementation
		assign nand1_out = ~(a & b);
		assign y = nand1_out;

	endmodule
