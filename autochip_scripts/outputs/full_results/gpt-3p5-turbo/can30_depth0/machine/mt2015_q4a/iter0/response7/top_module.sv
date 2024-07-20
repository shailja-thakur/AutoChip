module top_module(
	input x,
	input y,
	output z);
	
	// Declaration of intermediate wires
	wire xor_output;
	
	// Logic for intermediate wires
	xor xor_gate(.a(x), .b(y), .o(xor_output));
	
	// Assigning the output wire z to the final logic
	assign z = x & xor_output;
	
endmodule
