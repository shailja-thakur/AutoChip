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
	
	assign z = (x & y) | (~x & ~y);
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire out1, out2, out3, out4;
	A a1(.x(x), .y(y), .z(out1));
	B b1(.x(x), .y(y), .z(out2));
	A a2(.x(x), .y(y), .z(out3));
	B b2(.x(x), .y(y), .z(out4));
	
	wire temp1;
	wire temp2;
	
	assign temp1 = out1 | out2;
	assign temp2 = out3 & out4;
	assign z = temp1 ^ temp2;
endmodule
