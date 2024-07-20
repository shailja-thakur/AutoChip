module top_module (
    input [7:0] in,
    output parity
);
	
	// Wire declaration for the XOR gate input and the output
	wire [7:0] xor_input;
	wire xor_output;
	
	// Connect the input to the XOR gate input
	assign xor_input = in;
	
	// XOR gate implementation for parity calculation
	xor_gate xor_inst (
		.in(xor_input),
		.out(xor_output)
	);
	
	// Assign the output of the XOR gate to the parity output
	assign parity = xor_output;
	
endmodule
module xor_gate (
    input [7:0] in,
    output out
);
	assign out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
endmodule
