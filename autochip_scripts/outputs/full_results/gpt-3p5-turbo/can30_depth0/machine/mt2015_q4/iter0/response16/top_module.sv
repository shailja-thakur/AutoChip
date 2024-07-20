module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	wire a;
	wire b;

	// Instantiate logic gates
	and_gate and1(x, y, a);
	or_gate or1(x, y, b);
	xor_gate xor1(a, b, z);

endmodule
module and_gate(
	input a,
	input b,
	output c);

	assign c = a & b;

endmodule
module or_gate(
	input a,
	input b,
	output c);

	assign c = a | b;

endmodule
module xor_gate(
	input a,
	input b,
	output c);

	assign c = a ^ b;

endmodule
