module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire or_ab, or_cd;

    // Implement the bitwise OR operations
    assign or_ab = a | b;
    assign or_cd = c | d;

    // Implement the bitwise AND operation
    assign q = or_ab & or_cd;

endmodule
