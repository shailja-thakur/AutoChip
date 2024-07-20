module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire or_ab, or_cd;

    assign or_ab = a | b;  // Bitwise OR of a and b
    assign or_cd = c | d;  // Bitwise OR of c and d
    assign q = or_ab & or_cd;  // Bitwise AND of the two ORs

endmodule
