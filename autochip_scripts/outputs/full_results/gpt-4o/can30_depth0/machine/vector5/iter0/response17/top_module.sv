module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vector1;
    wire [24:0] vector2;

    // Construct the first 25-bit vector: ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
    assign vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Construct the second 25-bit vector: {5{a,b,c,d,e}}
    assign vector2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Compute the bitwise exclusive-or of the two vectors
    assign out = vector1 ^ vector2;

endmodule
