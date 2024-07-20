module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate minimized sum-of-products for the required output out_sop
    // The positions are: out_sop = 1 for 2, 7, 15
    assign out_sop = (a & b & c & d) | 
                     (a & ~b & c & d) | 
                     (~a & b & ~c & d);

    // Generate minimized product-of-sums for the required output out_pos
    // The positions are: out_pos = 0 for 0, 1, 4, 5, 6, 9, 10, 13, 14
    assign out_pos = (a | b | c | d) & 
                     (a | b | c | ~d) & 
                     (a | b | ~c | d) & 
                     (a | ~b | c | d) & 
                     (~a | b | c | d);

endmodule
