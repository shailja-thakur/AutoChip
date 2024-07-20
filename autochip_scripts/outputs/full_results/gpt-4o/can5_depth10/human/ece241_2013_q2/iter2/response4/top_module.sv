module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimized sum-of-products form
    // Generates a logic-1 for the numbers 2, 7, and 15
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     (~a & b & c & d)   | // 7
                     (a & b & c & d);   // 15
    
    // Minimized product-of-sums form
    // Generates a logic-1 for the numbers 2, 7, and 15
    assign out_pos = (a | b | ~c | ~d) & // Not 0, 1, 4, 5, 6, 9, 10, 13, 14
                     (a | ~b | ~c | ~d) & // Not 0, 1, 4, 5, 6, 9, 10, 13, 14
                     (a | ~b | ~c | d) &  // Not 0, 1, 4, 5, 6, 9, 10, 13, 14
                     (~a | b | c | d);   //  Not 0, 1, 4, 5, 6, 9, 10, 13, 14

endmodule
