module top_module(
	input x,
	input y,
	output z);

	// Gates
	wire a1_out, a2_out, b1_out, b2_out;

	and_gate a1(.a(x), .b(y), .z(a1_out));
	and_gate a2(.a(y), .b(x), .z(a2_out));
	or_gate b1(.a(x), .b(y), .z(b1_out));
	or_gate b2(.a(y), .b(x), .z(b2_out));
	and_gate c1(.a(a1_out), .b(b2_out), .z(z));
	
endmodule
module and_gate(
	input a,
	input b,
	output z);
	
	assign z = a & b;
	
endmodule
module or_gate(
	input a,
	input b,
	output z);
	
	assign z = a | b;
	
endmodule
