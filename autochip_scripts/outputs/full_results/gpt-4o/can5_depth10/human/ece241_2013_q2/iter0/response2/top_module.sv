module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    // Minimized sum-of-products form
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     (~a & b & c & d)   | // 7
                     (a & b & c & d);     // 15
    
    // Minimized product-of-sums form
    assign out_pos = (a | b | ~c | d) &  // Not 0, 1, 4, 5, 6, 9, 10, 13, 14
                     (~a | ~b | c)   &  // Not 1, 5, 7, 9, 13, 15
                     (~a | b | ~c)   &  // Not 1, 4, 5, 7, 6, 13, 14, 15
                     (~a | b | d)    &  // Not 1, 5, 6, 9, 10, 13, 14, 15
                     (a | ~b | ~d);   // Not 1, 4, 5, 6, 9, 10, 13, 14

endmodule
