module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

    wire [24:0] vec1;
    wire [24:0] vec2;

    // Create the first vector
    assign vec1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Create the second vector
    assign vec2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Compute the bitwise exclusive-or of the two vectors
    assign out = vec1 ^ vec2;

endmodule
