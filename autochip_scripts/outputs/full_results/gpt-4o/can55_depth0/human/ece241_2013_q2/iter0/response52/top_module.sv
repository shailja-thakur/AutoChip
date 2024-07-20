module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-Of-Products (SOP) form for out_sop
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     (a & b & c & ~d)   | // 7
                     (a & b & c & d);     // 15

    // Minimum Product-Of-Sums (POS) form for out_pos
    assign out_pos = (a | b | ~c | d) &   // 0, 1, 4, 9
                     (a | ~b | ~c | ~d) & // 1, 5, 6, 9, 13
                     (~a | ~b | c | d) &  // 2, 7, 15, 14
                     (~a | b | ~c | d) &  // 0, 4, 5, 6, 13, 14, 10
                     (a | b | c | ~d) ;   // 7, 15, 2, 14, 13

endmodule
