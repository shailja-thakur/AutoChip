module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Compute output in minimized sum-of-products form
    assign out_sop = ( (~a & ~b & c & ~d)  // 2
                       || (~a & b & c & d)   // 7
                       || (a & b & c & d));  // 15

    // Compute output in minimized product-of-sums form
    assign out_pos = ((a | ~b | ~c | d)     // 0, 1, 4, 5, 6, 9, 10, 13, and 14
                      && (a | b | c)        // not 3, 8, 11, or 12
                      && (~a | ~b | ~c | d) // 13
                      && (a | b | c | d));  // either 2, 7, 15 occurrences

endmodule
