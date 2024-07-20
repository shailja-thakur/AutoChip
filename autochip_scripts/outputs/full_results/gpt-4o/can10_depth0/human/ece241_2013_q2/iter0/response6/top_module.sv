module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-of-Products form (SOP)
    assign out_sop = (~a & ~b & c & ~d) | // 0010 (2)
                     (a & b & c & ~d) |   // 0111 (7)
                     (a & b & c & d);     // 1111 (15)

    // Minimum Product-of-Sums form (POS)
    assign out_pos = (a | ~b | ~c | d) &  // covers 0, 1, 4, 5, 9, 13, 14
                     (a | b | c | d) &    // covers 0, 1, 4, 5, 9, 10, 13, 14
                     (a | b | ~c) &       // covers 0, 1, 6, 10, 13
                     (~a | ~b | c | ~d) & // covers 1, 4, 5, 9, 14
                     (~a | ~b | ~c | ~d); // covers 1

endmodule
