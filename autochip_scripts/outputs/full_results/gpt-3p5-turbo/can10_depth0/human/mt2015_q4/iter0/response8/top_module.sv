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
	
	assign z = (x & ~y) | (y & ~x);
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	A a1(x, y, a_out1);
	B b1(x, y, b_out1);
	A a2(x, y, a_out2);
	B b2(x, y, b_out2);

	or_gate or1(a_out1, b_out1, or_out);
	and_gate and1(a_out2, b_out2, and_out);
	xor_gate xor1(or_out, and_out, z);
	
endmodule
