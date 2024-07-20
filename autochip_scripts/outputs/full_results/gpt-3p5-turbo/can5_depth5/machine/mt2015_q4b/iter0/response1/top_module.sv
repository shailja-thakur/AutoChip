module top_module(
	input x,
	input y,
	output z);

	// Declare internal wire signals
	wire xor_out;

	// XOR gate
	xor xor_gate(xor_out, x, y);

	// NOT gate
	not not_gate(z, xor_out);

endmodule
module xor(
	output reg out,
	input a,
	input b);

	always @(a or b)
		out = a ^ b;

endmodule
module not(
	output reg out,
	input a);

	always @(a)
		out = ~a;

endmodule
