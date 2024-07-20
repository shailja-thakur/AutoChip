module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// generate the first vector ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
	wire [24:0] vector1;
	assign vector1 = ~(5'a) & ~(5'b) & ~(5'c) & ~(5'd) & ~(5'e);

	// generate the second vector {5{a,b,c,d,e}}
	wire [24:0] vector2;
	assign vector2 = {5{a,b,c,d,e}};

	// compute the bitwise exclusive-or of the two vectors
	assign out = vector1 ^ vector2;

endmodule
