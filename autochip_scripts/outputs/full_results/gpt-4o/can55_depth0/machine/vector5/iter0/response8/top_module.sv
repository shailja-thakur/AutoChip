module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// Create the first and second 25-bit vectors
	wire [24:0] first_vector;
	wire [24:0] second_vector;

	assign first_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
	assign second_vector = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

	// Compute the bitwise exclusive-or of the two vectors
	assign out = first_vector ^ second_vector;

endmodule
