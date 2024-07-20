module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire or_ab, or_cd;

    // Bitwise OR of a and b
    assign or_ab = a | b;

    // Bitwise OR of c and d
    assign or_cd = c | d;

    // Bitwise AND of the two ORs
    assign q = or_ab & or_cd;

endmodule
