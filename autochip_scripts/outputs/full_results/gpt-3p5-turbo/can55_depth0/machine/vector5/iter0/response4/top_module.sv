module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
	// Create the 25-bit vector for the first input
	reg [24:0] first_vector;
	assign first_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

	// Create the 25-bit vector for the second input
	reg [24:0] second_vector;
	assign second_vector = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

	// Perform bitwise exclusive-or of the two vectors
	assign out = first_vector ^ second_vector;
endmodule
