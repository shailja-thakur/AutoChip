module top_module(
	input x,
	input y,
	output z);

	// Internal wire declaration
	wire w1;
	
	// XOR gate implementation
	xor_gate xor1(x, y, w1);
	
	// NOT gate implementation
	not_gate not1(w1, z);	

endmodule
module xor_gate(
	input a,
	input b,
	output c);

	assign c = a ^ b;

endmodule
module not_gate(
	input a,
	output b);

	assign b = ~a;

endmodule
