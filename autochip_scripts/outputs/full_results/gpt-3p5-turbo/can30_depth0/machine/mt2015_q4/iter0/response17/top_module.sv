module top_module(
	input x,
	input y,
	output z);
	
	// Gates
	wire a1, b1, a2, b2, a3, b3;
	
	// First gate
	and_gate u1(
		.a(x),
		.b(y),
		.z(a1)
	);
	
	// Second gate
	and_gate u2(
		.a(y),
		.b(x),
		.z(b1)
	);
	
	// Third gate
	and_gate u3(
		.a(a1),
		.b(b1),
		.z(z)
	);
	
endmodule
