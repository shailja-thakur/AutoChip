module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vector1, vector2;

    // Construct the first vector by concatenating 5-replicated signals and negating them
    assign vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Construct the second vector by replicating the concatenation of the signals 5 times
    assign vector2 = {5{a, b, c, d, e}};

    // Compute the bitwise exclusive-or of the two vectors
    assign out = vector1 ^ vector2;

endmodule
