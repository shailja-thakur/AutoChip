module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

	// Generate the first 25-bit vector
	reg [24:0] vector1;
	always @(a, b, c, d, e) begin
		vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
	end

	// Generate the second 25-bit vector
	reg [24:0] vector2;
	always @(a, b, c, d, e) begin
		vector2 = {5{a, b, c, d, e}};
	end

	// Compute the bitwise exclusive-or of the two vectors
	assign out = vector1 ^ vector2;

endmodule
