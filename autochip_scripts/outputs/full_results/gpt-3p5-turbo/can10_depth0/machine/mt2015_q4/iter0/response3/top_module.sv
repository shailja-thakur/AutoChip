module top_module(
	input x,
	input y,
	output z);

	// Define signals for the intermediate outputs
	wire a1, b1, a2, b2;

	// Instantiate gates
	and_gate and1(.a(x), .b(y), .z(a1));
	or_gate or1(.a(x), .b(y), .z(b1));
	and_gate and2(.a(a1), .b(b1), .z(a2));
	or_gate or2(.a(a1), .b(b1), .z(b2));
	and_gate and3(.a(a2), .b(b2), .z(z));

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
