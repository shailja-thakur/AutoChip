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
	
	assign z = (x & y) | (~x & ~y);
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	A a1(
		.x(x),
		.y(y),
		.z(a1_z)
	);
	B b1(
		.x(x),
		.y(y),
		.z(b1_z)
	);
	
	A a2(
		.x(x),
		.y(y),
		.z(a2_z)
	);
	B b2(
		.x(x),
		.y(y),
		.z(b2_z)
	);
	
	wire a1_z, b1_z, a2_z, b2_z;
	
	assign z = (a1_z | b1_z) ^ (a2_z & b2_z);
	
endmodule
