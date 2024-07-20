module top_module(
	input x,
	input y,
	output z);

	wire [1:0] z1, z2, z3, z4, or_out, and_out;
	A A1(x, y, z1[0]);
	A A2(x, y, z2[0]);
	B B1(x, y, z3[0]);
	B B2(x, y, z4[0]);

	OR2 my_or(z1[0], z3[0], or_out[0]);
	AND2 my_and(z2[0], z4[0], and_out[0]);
	XOR2 my_xor(or_out[0], and_out[0], z);
	
endmodule
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

	assign z = (x & ~y) | (~x & y);
	
endmodule
module OR2(
	input a,
	input b,
	output z);

	assign z = a | b;

endmodule
module AND2(
	input a,
	input b,
	output z);

	assign z = a & b;

endmodule
module XOR2(
	input a,
	input b,
	output z);

	assign z = a ^ b;

endmodule
