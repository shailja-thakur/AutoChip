module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vect1, vect2;

    // Creating the first 25-bit vector with bitwise NOT and replication
    assign vect1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Creating the second 25-bit vector with repeating the input signals
    assign vect2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Computing the bitwise XOR of the two vectors
    assign out = vect1 ^ vect2;

endmodule
