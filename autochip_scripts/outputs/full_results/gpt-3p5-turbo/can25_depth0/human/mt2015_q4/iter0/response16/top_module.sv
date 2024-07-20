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
	
	assign z = x & y;
	
endmodule
module OR_gate(
	input a,
	input b,
	output z);
	
	assign z = a | b;
	
endmodule
module AND_gate(
	input a,
	input b,
	output z);
	
	assign z = a & b;
	
endmodule
module XOR_gate(
	input a,
	input b,
	output z);
	
	assign z = a ^ b;
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1, b_out1, a_out2, b_out2, or_out, and_out;
	
	A a1(.x(x), .y(y), .z(a_out1));
	B b1(.x(x), .y(y), .z(b_out1));
	A a2(.x(x), .y(y), .z(a_out2));
	B b2(.x(x), .y(y), .z(b_out2));
	
	OR_gate or1(.a(a_out1), .b(b_out1), .z(or_out));
	AND_gate and1(.a(a_out2), .b(b_out2), .z(and_out));
	XOR_gate xor1(.a(or_out), .b(and_out), .z(z));
	
endmodule
