module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
    wire [24:0] vec1, vec2;
    
    // Constructing the 25-bit vectors
    assign vec1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign vec2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Compute the bitwise exclusive-or of the two vectors
    assign out = vec1 ^ vec2;
    
endmodule
