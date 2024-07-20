module top_module(
    input a, 
    input b,
    output out
);
	
	// Implementing XNOR gate using NAND gates
	// XNOR gate = ((a NAND b) NAND (a NAND b))

	// Internal wires
	wire nand1_out;
	
	// Instantiating NAND gates
	nand_gate nand1(
		.a(a),
		.b(b),
		.out(nand1_out)
	);
	
	nand_gate nand2(
		.a(nand1_out),
		.b(nand1_out),
		.out(out)
	);
	
	// Define NAND gate module
	module nand_gate(
		input a,
		input b,
		output out
	);
		
		// Internal wires
		wire nand_out;
		
		// Logic for NAND gate
		assign nand_out = ~(a & b);
		assign out = nand_out;
		
	endmodule
