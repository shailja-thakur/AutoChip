module top_module(
	input x,
	input y,
	output z);

	// Wire declarations
	wire xor_out, and_out;
	
	// XOR gate
	xor_gate xor_inst(
		.a(x),
		.b(y),
		.z(xor_out)
	);

	// AND gate
	and_gate and_inst(
		.a(xor_out),
		.b(x),
		.z(and_out)
	);

	// Output assignment
	assign z = and_out;

endmodule
module xor_gate(
	input a,
	input b,
	output z);
	
	assign z = a ^ b;
	
endmodule
module and_gate(
	input a,
	input b,
	output z);
	
	assign z = a & b;
	
endmodule
