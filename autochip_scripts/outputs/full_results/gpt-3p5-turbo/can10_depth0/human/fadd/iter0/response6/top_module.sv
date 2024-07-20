module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wires and signals declarations
	wire s1, co1, co2;

	// Definitions for the first stage of the full adder
	xor x1 (s1, a, b);
	and a1 (co1, a, b);
	
	// Definitions for the second stage of the full adder
	xor x2 (sum, s1, cin);
	and a2 (co2, s1, cin);

	// Output connections
	assign cout = co1 | co2;

endmodule
