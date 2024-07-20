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
    assign out_pos = (~a | ~b | ~c) &  // Not 0, 1, 4, 5, 9, 10, 13, 14
                     (~a | ~b | ~d) &  // Not 0, and not 6, 7, 14, 15
                     (~b | ~c | ~d) &  // Not 0, 1, 6, 7, 9, 10, 13, 14
                     (~a | ~c | ~d);   // Not 0, and not 5, 6, 7, 10, 11, 14, 15

endmodule
