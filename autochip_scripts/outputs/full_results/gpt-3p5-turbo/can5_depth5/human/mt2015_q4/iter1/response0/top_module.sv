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
	
	reg z;
	
	always @(*)
	begin
		#5 z = (x & y) | z;
	end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out, b_out;
	
	A a1(
		.x(x),
		.y(y),
		.z(a_out)
	);
	
	A a2(
		.x(x),
		.y(y),
		.z(b_out)
	);
	
	B b1(
		.x(a_out),
		.y(b_out),
		.z(z1)
	);
	
	B b2(
		.x(a_out),
		.y(b_out),
		.z(z2)
	);
	
	OR gate1(
		.in1(a_out),
		.in2(b_out),
		.out(or_out)
	);
	
	AND gate2(
		.in1(a_out),
		.in2(b_out),
		.out(and_out)
	);
	
	XOR gate3(
		.in1(or_out),
		.in2(and_out),
		.out(z)
	);
	
endmodule
