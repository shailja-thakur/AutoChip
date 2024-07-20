module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// The first vector
	wire [24:0] vector1;
	assign vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

	// The second vector
	wire [24:0] vector2;
	assign vector2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

	// XOR operation
	assign out = vector1 ^ vector2;

endmodule
