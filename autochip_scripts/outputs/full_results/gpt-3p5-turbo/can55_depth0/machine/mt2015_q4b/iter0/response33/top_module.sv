module top_module(
	input x,
	input y,
	output z
);
	// Declare internal wire
	wire temp;

	// XOR gate
	xor_gate U1(
		.a(x),
		.b(y),
		.z(temp)
	);

	// NOT gate
	not_gate U2(
		.a(temp),
		.z(z)
	);

endmodule
module xor_gate(
	input a,
	input b,
	output z
);
	assign z = a ^ b;
endmodule
module not_gate(
	input a,
	output z
);
	assign z = ~a;
endmodule
