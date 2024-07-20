module A(
	input x,
	input y,
	output z);

	assign z = (x ^ y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	assign z = #5 (x & y);

endmodule
module top_module(
	input x,
	input y,
	output z);

  wire a1_z, a2_z, b1_z, b2_z;
  
	A a1(
		.x(x),
		.y(y),
		.z(a1_z)
	);
	
	A a2(
		.x(x),
		.y(y),
		.z(a2_z)
	);
	
	B b1(
		.x(x),
		.y(y),
		.z(b1_z)
	);
	
	B b2(
		.x(x),
		.y(y),
		.z(b2_z)
	);
	
	wire or_out, and_out;
	
	or or_gate(
		.a(a1_z),
		.b(b1_z),
		.z(or_out)
	);
	
	and and_gate(
		.a(a2_z),
		.b(b2_z),
		.z(and_out)
	);
	
	xor xor_gate(
		.a(or_out),
		.b(and_out),
		.z(z)
	);

endmodule
