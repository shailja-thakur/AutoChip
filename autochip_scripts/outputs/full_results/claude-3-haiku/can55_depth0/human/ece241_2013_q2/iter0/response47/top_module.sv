module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Minimum sum-of-products form
assign out_sop = (a & ~b & ~c & ~d) | // 0
                 (~a & b & ~c & ~d) | // 1
                 (~a & ~b & c & ~d) | // 4
                 (~a & ~b & ~c & d) | // 5
                 (~a & ~b & d & d) | // 6
                 (a & b & c & ~d) | // 7
                 (~a & b & d & d) | // 9
                 (a & ~b & d & d) | // 10
                 (~a & c & d & d) | // 13
                 (a & b & d & d); // 15

// Minimum product-of-sums form
assign out_pos = (~a | ~b | ~c) & // 0, 1, 4, 5, 6
                 (a | b | ~c) & // 7
                 (~a | b | d) & // 9, 10
                 (a | c | d) & // 13
                 (a | b | d); // 15

endmodule
