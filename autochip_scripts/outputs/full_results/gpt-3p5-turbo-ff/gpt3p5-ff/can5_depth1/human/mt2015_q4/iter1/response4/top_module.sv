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
	
	assign z = (x & ~y) | (y & ~x);
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire out_A1, out_A2, out_B1, out_B2;
	wire or_out, and_out;
	
	A inst_A1(.x(x), .y(y), .z(out_A1));
	B inst_B1(.x(x), .y(y), .z(out_B1));
	
	A inst_A2(.x(x), .y(y), .z(out_A2));
	B inst_B2(.x(x), .y(y), .z(out_B2));
	
	or gate_or(.a(out_A1), .b(out_B1), .z(or_out));
	and gate_and(.a(out_A2), .b(out_B2), .z(and_out));
	
	xor gate_xor(.a(or_out), .b(and_out), .z(z));
endmodule
