module top_module(
	input x,
	input y,
	output z);

	// First logic gate
	and gate1(.a(x), .b(y), .z(w1));

	// Second logic gate
	and gate2(.a(y), .b(x), .z(w2));

	// Third logic gate
	or gate3(.a(w1), .b(w2), .z(z));

endmodule
