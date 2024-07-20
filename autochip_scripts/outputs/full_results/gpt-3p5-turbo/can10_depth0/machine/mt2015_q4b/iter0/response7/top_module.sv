module top_module(
	input x,
	input y,
	output z);

	// internal signals
	wire xor_out, or_out;

	// XOR gate
	xor_gate xor1(x, y, xor_out);

	// OR gate
	or_gate or1(x, y, or_out);

	// NOT gate
	not_gate not1(or_out, z);

endmodule
module xor_gate(
	input a,
	input b,
	output c);

	assign c = a ^ b;

endmodule
module or_gate(
	input a,
	input b,
	output c);

	assign c = a | b;

endmodule
module not_gate(
	input a,
	output b);

	assign b = ~a;

endmodule
