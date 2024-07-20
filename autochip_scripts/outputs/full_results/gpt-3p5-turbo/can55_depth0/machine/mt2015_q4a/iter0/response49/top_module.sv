module top_module(
	input x,
	input y,
	output z);
	// Signal declaration
	wire a, b, c;
	
	// Logic implementation
	xor_gate U1 (.a(x), .b(y), .o(a));
	not_gate U2 (.a(y), .o(b));
	and_gate U3 (.a(a), .b(x), .o(c));
	or_gate U4 (.a(b), .b(c), .o(z));
	
endmodule
module xor_gate(
	input a,
	input b,
	output o);
	
	// Logic implementation
	assign o = a ^ b;
	
endmodule
module not_gate(
	input a,
	output o);
	
	// Logic implementation
	assign o = ~a;
	
endmodule
module and_gate(
	input a,
	input b,
	output o);
	
	// Logic implementation
	assign o = a & b;
	
endmodule
module or_gate(
	input a,
	input b,
	output o);
	
	// Logic implementation
	assign o = a | b;
	
endmodule
