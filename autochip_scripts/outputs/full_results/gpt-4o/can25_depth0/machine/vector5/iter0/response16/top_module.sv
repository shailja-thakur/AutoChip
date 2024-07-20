module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

    // Generating the first 25-bit vector ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
    wire [24:0] v1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Generating the second 25-bit vector {5{a,b,c,d,e}}
    wire [24:0] v2 = {5{a, b, c, d, e}};
    
    // Compute the bitwise XOR of the two vectors
    assign out = v1 ^ v2;

endmodule
