module A(
	input x,
	input y,
	output z
);
	
	assign z = (x ^ y) & x;
	
endmodule
module B(
	input x,
	input y,
	output z
);
	
	reg z_reg;
	
	always @(*)
	begin
		#5 z_reg = (x & y) | z_reg;
	end
	
	assign z = z_reg;
	
endmodule
module top_module(
	input x,
	input y,
	output z
);
	
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
		.x(a1_z),
		.y(b1_z),
		.z(b1_z)
	);
	
	B b2(
		.x(a2_z),
		.y(b2_z),
		.z(b2_z)
	);
	
	assign z = a1_z ^ b1_z ^ a2_z & b2_z;
	
endmodule
module top(
	input x,
	input y,
	output z
);
	
	top_module inst1(
		.x(x),
		.y(y),
		.z(z)
	);
	
endmodule
