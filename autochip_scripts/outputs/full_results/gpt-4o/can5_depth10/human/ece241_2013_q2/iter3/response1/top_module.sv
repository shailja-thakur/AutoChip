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
                     (a & b & c & d);   // 15
    
    // Minimized product-of-sums form
    assign out_pos = (b | ~c | d) &          // Not 0
                     (a | ~c | ~d) &         // Not 1
                     (a | b | d) &           // Not 4
                     (a | b | ~d) &          // Not 5
                     (a | c | ~d) &          // Not 6
                     (~a | ~b | d) &         // Not 9
                     (a | d) &               // Not 10
                     (a | ~b | ~c | ~d) &    // Not 13
                     (~a | ~b | ~c | ~d) &   // Not 14
                     1'b1;                   // To handle other cases that never occur

endmodule
