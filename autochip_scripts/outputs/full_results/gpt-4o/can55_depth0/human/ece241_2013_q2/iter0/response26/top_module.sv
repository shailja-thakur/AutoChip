module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of Products (SOP) form for 2, 7, 15
    assign out_sop = (~a & ~b & c & ~d) | // 2: 0010
                     (a & b & c & ~d) |   // 7: 0111
                     (a & b & c & d);     // 15: 1111

    // Product of Sums (POS) form for 0, 1, 4, 5, 6, 9, 10, 13, 14
    assign out_pos = (a | b | c | ~d) &   // 0, 1, 4, 5, 6, 9, 13: 0xx0, 1xx1 (for x = 0 or 1)
                     (a | ~b | ~c | ~d) & // 0, 1, 4, 5, 6, 13, 14: 10xx, 0x0x: 10xx, 00x0, 01x0
                     (~a | b | c | d);    // excludes 2, 7, and 15

endmodule
