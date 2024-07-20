module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// First vector: 5 repeats of each input signal, then bitwise NOT applied
	wire [24:0] vec1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

	// Second vector: 5 repeats of the concatenated inputs
	wire [24:0] vec2 = {5{a, b, c, d, e}};

	// Output is the bitwise XOR of the two vectors
	assign out = vec1 ^ vec2;

endmodule
