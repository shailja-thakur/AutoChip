module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

    // Generate the 25-bit vector with the repeated values of a, b, c, d, and e
    wire [24:0] vec1 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Generate the complemented 25-bit vector with the repeated values of a, b, c, d, and e
    wire [24:0] vec2 = ~vec1;
    
    // Assign the output to the XOR of the two vectors
    assign out = vec2 ^ vec1;
    
endmodule
