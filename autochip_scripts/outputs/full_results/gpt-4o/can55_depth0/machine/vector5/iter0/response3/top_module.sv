module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // Create the first 25-bit vector: ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
    wire [24:0] vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
	
    // Create the second 25-bit vector: {5{a,b,c,d,e}}
    wire [24:0] vector2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Compute the bitwise exclusive-or (XOR) of the two vectors
    assign out = vector1 ^ vector2;

endmodule
