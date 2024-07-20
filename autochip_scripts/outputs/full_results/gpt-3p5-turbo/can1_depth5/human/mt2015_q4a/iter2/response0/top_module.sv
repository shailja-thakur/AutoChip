module top_module(
	input x,
	input y,
	output z);

	// Intermediate signals
	wire a;
	wire b;
	
	// Output assignment
	assign z = b;

	// XOR gate to compute x^y
	xor gate_xor_1(a, x, y);
	
	// AND gate to compute (x^y) & x
	and gate_and_1(b, a, x);
	
endmodule
