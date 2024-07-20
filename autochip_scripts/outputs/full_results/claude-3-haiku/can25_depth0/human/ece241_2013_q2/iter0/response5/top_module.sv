module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Minimum sum-of-products form
assign out_sop = (a & ~b & ~c & ~d) // 0
               |(~a & b & ~c & ~d) // 1 
               |(~a & ~b & c & ~d) // 4
               |(~a & ~b & ~c & d) // 5
               |(~a & ~b & ~c & ~d) // 6
               |(a & b & c & ~d) // 7
               |(~a & b & c & d) // 9
               |(a & ~b & c & d) // 10
               |(a & b & ~c & d) // 13
               |(a & b & c & d); // 15

// Minimum product-of-sums form
assign out_pos = (~a | ~b | c | d) // 0, 1, 4, 5, 6, 13, 14, 15
                & (a | ~b | ~c | ~d) // 0, 2, 3, 7, 11, 12, 15
                & (~a | b | ~c | ~d) // 1, 2, 3, 5, 9, 11, 13
                & (a | b | ~c | d); // 7, 10, 11, 12, 13, 14, 15

endmodule
