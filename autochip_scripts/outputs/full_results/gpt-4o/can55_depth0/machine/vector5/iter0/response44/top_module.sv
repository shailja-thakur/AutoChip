module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    // Construct the first 25-bit vector, inverted and replicated
    wire [24:0] first_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Construct the second 25-bit vector, non-inverted and replicated
    wire [24:0] second_vector = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Compute the bitwise exclusive-or of the two vectors
    assign out = first_vector ^ second_vector;
endmodule
