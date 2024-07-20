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
	
	assign z = #0(x | y);
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	A A1(
		.x(x),
		.y(y),
		.z(a1_z)
	);
	
	B B1(
		.x(x),
		.y(y),
		.z(b1_z)
	);
	
	B B2(
		.x(x),
		.y(y),
		.z(b2_z)
	);
	
	A A2(
		.x(x),
		.y(y),
		.z(a2_z)
	);
	
	oror or_gate(
		.in1(a1_z),
		.in2(b1_z),
		.out(or_z)
	);
	
	andand and_gate(
		.in1(a2_z),
		.in2(b2_z),
		.out(and_z)
	);
	
	xor xor_gate(
		.in1(or_z),
		.in2(and_z),
		.out(z)
	);
	
endmodule
module oror(
	input in1,
	input in2,
	output out);
	
	assign out = in1 | in2;
	
endmodule
module andand(
	input in1,
	input in2,
	output out);
	
	assign out = in1 & in2;
	
endmodule
module xor(
	input in1,
	input in2,
	output out);
	
	assign out = in1 ^ in2;
	
endmodule
