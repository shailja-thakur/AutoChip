module top_module(
	input x,
	input y,
	output z);

	// Internal signals
	wire a;
	
	// Intermediate signals
	wire b;
	
	// Output assignment
	assign z = b;

	// XOR gate to compute x^y
	xor gate_xor_1(.a(x), .b(y), .z(a));
	
	// AND gate to compute (x^y) & x
	and gate_and_1(.a(a), .b(x), .z(b));
	
endmodule
