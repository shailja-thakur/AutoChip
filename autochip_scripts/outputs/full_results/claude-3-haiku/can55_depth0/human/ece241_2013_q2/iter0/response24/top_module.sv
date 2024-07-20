module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// out_sop in minimum sum-of-products form
assign out_sop = (~a & ~b & ~c & d) // 2
                | (a & b & c & ~d) // 7
                | (a & b & c & d); // 15

// out_pos in minimum product-of-sums form
assign out_pos = (~a | ~b | ~c | d) // 0, 1, 4, 5, 6, 9, 10, 13, 14
                & (a | ~b | ~c | ~d) // 0, 1, 2, 3
                & (~a | b | ~c | ~d) // 0, 4, 5, 8, 9, 12, 13
                & (~a | ~b | c | ~d); // 0, 1, 2, 5, 6, 7, 10, 11, 14, 15
endmodule
