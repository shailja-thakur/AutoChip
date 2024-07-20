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
	output y);
	
	assign y = a | b;
endmodule
module AND2(
	input a,
	input b,
	output y);
	
	assign y = a & b;
endmodule
module XOR2(
	input a,
	input b,
	output y);
	
	assign y = a ^ b;
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire z1, z2;
	
	A a1(.x(x), .y(y), .z(z1));
	B b1(.x(x), .y(y), .z(z1));
	
	A a2(.x(x), .y(y), .z(z2));
	B b2(.x(x), .y(y), .z(z2));
	
	OR2 or_gate(.a(z1), .b(z2), .y(z));
	AND2 and_gate(.a(z1), .b(z2), .y(z));
	
endmodule
