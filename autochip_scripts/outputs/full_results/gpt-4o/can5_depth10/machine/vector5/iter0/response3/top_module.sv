module top_module (
    input  a,
    input  b,
    input  c,
    input  d,
    input  e,
    output [24:0] out
);

    // construct the first 25-bit vector
    wire [24:0] vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // construct the second 25-bit vector
    wire [24:0] vector2 = {5{a, b, c, d, e}};

    // compute the bitwise exclusive-or of the two vectors
    assign out = vector1 ^ vector2;

endmodule
