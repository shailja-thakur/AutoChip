module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] a_vector;
    wire [24:0] b_vector;

    // Generate the first vector
    assign a_vector = ~{{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};

    // Generate the second vector
    assign b_vector = {5{a, b, c, d, e}};

    // Compute the bitwise exclusive-or of the two vectors
    assign out = a_vector ^ b_vector;

endmodule
