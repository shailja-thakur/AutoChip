module top_module(
	input x,
	input y,
	output z);

	// Declare internal wire for intermediate calculations
	wire x_xor_y;

	// Apply XOR gate to input signals
	xor_gate xor1(.a(x), .b(y), .z(x_xor_y));

	// Apply negation to XOR output
	not_gate not1(.a(x_xor_y), .z(z));
endmodule
module xor_gate(
	input a,
	input b,
	output z);
	
	assign z = a ^ b;
endmodule
module not_gate(
	input a,
	output z);
	
	assign z = ~a;
endmodule
