module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// out_sop in minimum sum-of-products form
assign out_sop = (a & ~b & ~c & ~d) | // 2
                (~a & b & c & d) | // 7
                (a & b & c & d); // 15

// out_pos in minimum product-of-sums form
assign out_pos = (~a | ~b) & (~a | ~c) & (~a | ~d) & // 0
                 (a | ~b | ~c | ~d) & // 1
                 (a | b | ~c | ~d) & // 4
                 (a | b | c | ~d) & // 5
                 (a | b | c | d); // 6

endmodule
