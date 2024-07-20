module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire ab, cd;

    // Calculate the bitwise OR of a and b
    assign ab = a | b;

    // Calculate the bitwise OR of c and d
    assign cd = c | d;

    // Calculate the bitwise AND of the two ORs
    assign q = ab & cd;

endmodule
