module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// out_sop in minimum sum-of-products form
assign out_sop = (~a & ~b & ~c & d) | // 1
                 (~a & b & ~c & ~d) | // 5
                 (~a & b & c & ~d) | // 6
                 (a & ~b & ~c & d) | // 7
                 (a & ~b & c & ~d) | // 13
                 (a & b & c & d);   // 15

// out_pos in minimum product-of-sums form
assign out_pos = (a + b + ~c + d) & // 1, 3, 5, 7, 9, 11, 13, 15
                 (a + ~b + ~c + ~d) & // 0, 1, 4, 5, 12, 13
                 (~a + b + ~c + d) & // 1, 3, 7, 9, 11, 15
                 (~a + ~b + c + ~d); // 4, 6, 12, 14
endmodule
