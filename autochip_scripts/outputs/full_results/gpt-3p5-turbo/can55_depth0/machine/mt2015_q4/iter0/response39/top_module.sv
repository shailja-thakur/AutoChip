module top_module(
	input x,
	input y,
	output z);
	
	wire a, b;
	
	// First gate
	and_gate first_gate(
		.a(x),
		.b(y),
		.z(a)
	);
	
	// Second gate
	and_gate second_gate(
		.a(y),
		.b(x),
		.z(b)
	);
	
	// Third gate
	and_gate third_gate(
		.a(a),
		.b(b),
		.z(z)
	);
	
endmodule
module and_gate(
	input a,
	input b,
	output z);
	
	assign z = a & b;
	
endmodule
