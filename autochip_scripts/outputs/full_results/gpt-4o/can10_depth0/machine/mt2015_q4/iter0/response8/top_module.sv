module top_module(
	input x,
	input y,
	output z);
	
	wire a1, a2;

	// First gate (e.g., AND gate)
	assign a1 = x & y;

	// Second gate (e.g., OR gate)
	assign a2 = x | y;

	// Third gate (e.g., XOR gate)
	assign z = a1 ^ a2;

endmodule
