module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] bit_wise_one;
    wire [24:0] bit_wise_two;

    // Compute the bitwise exclusive-or of the first 25-bit vector
    assign bit_wise_one = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Compute the bitwise exclusive-or of the second 25-bit vector
    assign bit_wise_two = {5{a,b,c,d,e}};

    // Compute the bitwise exclusive-or of the two 25-bit vectors
    assign out = bit_wise_one ^ bit_wise_two;

endmodule
