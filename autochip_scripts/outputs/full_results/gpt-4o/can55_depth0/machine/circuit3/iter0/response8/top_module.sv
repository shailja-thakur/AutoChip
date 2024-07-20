module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire or_ab;
    wire or_cd;

    assign or_ab = a | b; // Bitwise OR of inputs a and b
    assign or_cd = c | d; // Bitwise OR of inputs c and d

    assign q = or_ab & or_cd; // Bitwise AND of the two OR results

endmodule
