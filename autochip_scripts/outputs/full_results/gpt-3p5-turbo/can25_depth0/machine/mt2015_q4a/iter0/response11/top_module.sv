module top_module(
	input x,
	input y,
	output z);

	// Internal signal declarations
	wire xor_output;
	
	// XOR gate for x and y
	xor_gate xor1(x, y, xor_output);

	// AND gate for xor_output and x
	and_gate and1(xor_output, x, z);
	
endmodule
module xor_gate(
	input a,
	input b,
	output y);
	xor y(a, b);
endmodule
module and_gate(
	input a,
	input b,
	output y);
	and y(a, b, y);
endmodule
