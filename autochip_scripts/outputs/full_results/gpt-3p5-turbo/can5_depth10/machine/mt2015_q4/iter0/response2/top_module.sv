module top_module(
	input x,
	input y,
	output z);

	// Instantiate gates
	and_gate and1(.a(x), .b(y), .o(w1)); // First gate with inputs x and y
	and_gate and2(.a(y), .b(x), .o(w2)); // Second gate with inputs y and x
	and_gate and3(.a(w1), .b(w2), .o(z)); // Third gate with inputs w1 and w2

endmodule
module and_gate(
	input a,
	input b,
	output o);

	assign o = a & b; // perform AND operation and assign the result to o

endmodule
