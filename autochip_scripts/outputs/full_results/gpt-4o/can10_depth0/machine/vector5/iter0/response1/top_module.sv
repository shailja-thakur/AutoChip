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

    // Create the first 25-bit vector with bitwise NOT operation
    assign vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Create the second 25-bit vector
    assign vector2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    
    // Compute the bitwise exclusive-or of the two vectors
    assign out = vector1 ^ vector2;

endmodule
