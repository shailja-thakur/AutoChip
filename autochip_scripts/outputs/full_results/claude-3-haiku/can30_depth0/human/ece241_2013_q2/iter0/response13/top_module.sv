module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Minimum sum-of-products (SOP) form
assign out_sop = (~a & ~b & ~c & ~d) | // 0
                (a & ~b & ~c & ~d) | // 1
                (~a & b & ~c & ~d) | // 4
                (~a & ~b & c & ~d) | // 5
                (~a & ~b & ~c & d) | // 6
                (a & b & c & ~d) | // 7
                (a & b & ~c & d) | // 14
                (a & ~b & c & d) | // 15
                (~a & b & c & d); // 13

// Minimum product-of-sums (POS) form
assign out_pos = (a | b | c | d) & // 0, 1, 4, 5, 6, 9, 10, 13, 14
                (~a | ~b | ~c) & // 2, 7, 15
                (~a | ~b | d) & // 2, 7, 14, 15
                (~a | c | ~d) & // 5, 7, 13, 15
                (b | ~c | ~d); // 4, 6, 7, 14

endmodule
