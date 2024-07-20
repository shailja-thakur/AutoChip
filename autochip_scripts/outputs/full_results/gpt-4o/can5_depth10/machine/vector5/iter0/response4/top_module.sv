module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// The first 25-bit vector ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
	wire [24:0] vect1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

	// The second 25-bit vector {5{a,b,c,d,e}}
	wire [24:0] vect2 = { 5{a, b, c, d, e} };

	// Output is the bitwise exclusive-or of the two vectors
	assign out = vect1 ^ vect2;

endmodule
