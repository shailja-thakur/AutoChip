module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimized sum-of-products form (covering only the desired outputs - 2, 7, 15)
    assign out_sop = (~a & ~b & c & ~d)    // 2
                   | (~a & b & c & d)      // 7
                   | (a & b & c & d);      // 15
    
    // Minimized product-of-sums form (covering only the desired outputs - 0, 1, 4, 5, 6, 9, 10, 13, 14)
    assign out_pos = (a | b | ~c | d)      // 0 must be 0
                   & (a | ~b | ~c | ~d)    // 1 must be 0
                   & (a | ~b | c | ~d)     // 4 must be 0
                   & (a | b | ~c | ~d)     // 5 must be 0
                   & (a | b | c | ~d)      // 6 must be 0
                   & (~a | ~b | ~c | d)    // 9 must be 0
                   & (~a | ~b | c | ~d)    // 10 must be 0
                   & (a | ~b | ~c | d)     // 13 must be 0
                   & (a | b | ~c | ~d);    // 14 must be 0
    
endmodule
