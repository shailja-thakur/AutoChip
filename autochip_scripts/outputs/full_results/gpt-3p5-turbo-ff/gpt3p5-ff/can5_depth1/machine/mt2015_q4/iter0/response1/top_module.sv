module top_module(
	input wire x,
	input wire y,
	output wire z);

	// Gate 1
	wire gate1_a;
	wire gate1_b;
	
	// Gate 2
	wire gate2_a;
	wire gate2_b;
	
	// Gate 3
	wire gate3_a;
	wire gate3_b;
	
	// Gate 1 logic
	and gate1(.a(x), .b(y), .z1(gate1_a), .z2(gate1_b));
	
	// Gate 2 logic
	and gate2(.a(y), .b(x), .z1(gate2_a), .z2(gate2_b));
	
	// Gate 3 logic
	or gate3(.a(gate1_a), .b(gate2_b), .z(z));
endmodule
