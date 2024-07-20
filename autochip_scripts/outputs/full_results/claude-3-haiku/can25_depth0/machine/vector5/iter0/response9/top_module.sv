module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // First vector: 25 bits with value 1 if the corresponding input is 0, and 0 if the corresponding input is 1
    wire [24:0] first_vector = ~{5{a}, 5{b}, 5{c}, 5{d}, 5{e}};

    // Second vector: 25 bits with value 1 if the corresponding input is 1, and 0 if the corresponding input is 0
    wire [24:0] second_vector = {5{a, b, c, d, e}};

    // Compute the bitwise XOR of the two vectors
    assign out = first_vector ^ second_vector;

endmodule
