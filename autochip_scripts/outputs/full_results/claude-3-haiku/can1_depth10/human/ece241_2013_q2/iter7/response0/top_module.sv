module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// out_sop in minimum sum-of-products form
assign out_sop = (a & b & ~c & ~d) | // 2
                 (a & b & c & d);   // 15

// out_pos in minimum product-of-sums form
assign out_pos = (~a | ~b | c | d) & // 0, 1, 7, 8, 15
                 (a | b | ~c | ~d) & // 2, 3, 9, 10, 11, 12
                 (a | b | c | ~d);   // 4, 5, 6, 13, 14
endmodule
