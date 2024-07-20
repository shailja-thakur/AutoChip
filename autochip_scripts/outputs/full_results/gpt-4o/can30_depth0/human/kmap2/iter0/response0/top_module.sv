module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Intermediate terms for simplicity
    wire s0, s1, s2, s3;

    assign s0 = ~c & ~d; // cd = 00
    assign s1 = ~c & d;  // cd = 01
    assign s2 = c & d;   // cd = 11
    assign s3 = c & ~d;  // cd = 10

    // Boolean expressions for each row in Karnaugh map
    // For the row cd = 00: ab = 00, 01, 11, 10 -> 1, 1, 0, 1 = ab pattern 0
    // For the row cd = 01: ab = 00, 01, 11, 10 -> 1, 0, 0, 1 = ab pattern 1
    // For the row cd = 11: ab = 00, 01, 11, 10 -> 0, 1, 1, 1 = ab pattern 1
    // For the row cd = 10: ab = 00, 01, 11, 10 -> 1, 1, 0, 0 = ab pattern 0

    assign out = (s0 & (~a | ~b | a & b)) |
                 (s1 & (~a & ~b | a & ~b)) |
                 (s2 & (a | b)) |
                 (s3 & (~b));

endmodule
