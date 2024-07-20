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
	
	wire a_output1, a_output2, b_output1, b_output2;
	wire or_output, and_output;
	
	A a1(.x(x), .y(y), .z(a_output1));
	A a2(.x(x), .y(y), .z(a_output2));
	B b1(.x(x), .y(y), .z(b_output1));
	B b2(.x(x), .y(y), .z(b_output2));
	
	or or_gate(.a(a_output1), .b(a_output2), .z(or_output));
	and and_gate(.a(b_output1), .b(b_output2), .z(and_output));
	xor xor_gate(.a(or_output), .b(and_output), .z(z));
	
endmodule
module or(
	input a,
	input b,
	output z);
	
	assign z = a | b;
endmodule
module and(
	input a,
	input b,
	output z);
	
	assign z = a & b;
endmodule
module xor(
	input a,
	input b,
	output z);
	
	assign z = a ^ b;
endmodule
