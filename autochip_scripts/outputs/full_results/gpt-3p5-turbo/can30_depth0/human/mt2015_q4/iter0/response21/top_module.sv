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
	
	assign z = ^x & ^y;
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	A a1(.x(x), .y(y), .z(a));
	B b1(.x(x), .y(y), .z(b));
	A a2(.x(a), .y(b), .z(c));
	B b2(.x(a), .y(b), .z(d));
	
	wire a, b, c, d;
	wire out_or, out_and;
	
	assign out_or = a | d;
	assign out_and = c & b;
	
	assign z = out_or ^ out_and;
endmodule
