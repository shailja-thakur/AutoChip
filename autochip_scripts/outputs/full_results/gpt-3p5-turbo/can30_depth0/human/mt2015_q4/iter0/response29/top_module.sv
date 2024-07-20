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
	
	assign z = #(5) (x & y);
endmodule
module top_module(
	input x,
	input y,
	output z
	);
	
	wire a1_z, a2_z, b1_z, b2_z;
	A a1(x, y, a1_z);
	A a2(x, y, a2_z);
	B b1(x, y, b1_z);
	B b2(x, y, b2_z);

	wire or_out, and_out;
	assign or_out = a1_z | b1_z;
	assign and_out = a2_z & b2_z;
	assign z = or_out ^ and_out;
endmodule
