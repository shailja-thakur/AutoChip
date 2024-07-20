module A(
	input x,
	input y,
	output z);
	
	assign z = (x^y) & x;
	
endmodule
module B(
	input x,
	input y,
	output z);
	
	assign z = #10 x & (~y);
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1, a_out2, b_out1, b_out2;
	wire or_out, and_out;
	
	A a1(.x(x), .y(y), .z(a_out1));
	A a2(.x(x), .y(y), .z(a_out2));
	
	B b1(.x(x), .y(y), .z(b_out1));
	B b2(.x(x), .y(y), .z(b_out2));
	
	or_gate or1(.a(a_out1), .b(b_out1), .z(or_out));
	and_gate and1(.a(a_out2), .b(b_out2), .z(and_out));
	
	xor_gate xor1(.a(or_out), .b(and_out), .z(z));
	
endmodule
module or_gate(
	input a,
	input b,
	output z);
	
	assign z = a | b;
	
endmodule
module and_gate(
	input a,
	input b,
	output z);
	
	assign z = a & b;
	
endmodule
module xor_gate(
	input a,
	input b,
	output z);
	
	assign z = a ^ b;
	
endmodule
