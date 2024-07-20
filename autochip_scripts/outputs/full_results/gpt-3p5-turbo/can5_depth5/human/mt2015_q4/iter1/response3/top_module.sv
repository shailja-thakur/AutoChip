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
	output z_output);
	
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
	
	assign z_output = z1 ^ z2;
	
endmodule
