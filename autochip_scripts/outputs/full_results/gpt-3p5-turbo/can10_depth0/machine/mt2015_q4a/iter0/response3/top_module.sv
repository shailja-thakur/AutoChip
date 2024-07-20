module top_module(
	input x,
	input y,
	output z);
	
	// Intermediate signals
	wire w1;
	wire w2;
	wire w3;
	
	// XOR operation
	xor_gate x1(.a(x), .b(y), .z(w1));
	
	// AND operation
	and_gate a1(.a(w1), .b(x), .z(w2));
	
	// Inverter for y input
	not_gate n1(.a(y), .z(w3));
	
	// OR operation of inverted y and input x
	or_gate o1(.a(w2), .b(w3), .z(z));
	
endmodule
module xor_gate(
	input a,
	input b,
	output z);
	
	assign z = a ^ b;
	
endmodule
module and_gate(
	input a,
	input b,
	output z);
	
	assign z = a & b;
	
endmodule
module not_gate(
	input a,
	output z);
	
	assign z = ~a;
	
endmodule
module or_gate(
	input a,
	input b,
	output z);
	
	assign z = a | b;
	
endmodule
