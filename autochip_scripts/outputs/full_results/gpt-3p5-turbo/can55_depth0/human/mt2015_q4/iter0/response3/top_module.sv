module A(
	input x,
	input y,
	output z
	);
	
	assign z = (x^y) & x;
	
endmodule
module B(
	input x,
	input y,
	output z
	);
	
	assign z = #0 x & y;
	
endmodule
module top_module(
	input x,
	input y,
	output z
	);
	
	wire z_a1, z_a2, z_b1, z_b2, z_or, z_and;
	
	A a1(x, y, z_a1);
	B b1(x, y, z_b1);
	
	A a2(x, y, z_a2);
	B b2(x, y, z_b2);
	
	assign z_or = z_a1 | z_b1;
	assign z_and = z_a2 & z_b2;
	
	assign z = z_or ^ z_and;
	
endmodule
