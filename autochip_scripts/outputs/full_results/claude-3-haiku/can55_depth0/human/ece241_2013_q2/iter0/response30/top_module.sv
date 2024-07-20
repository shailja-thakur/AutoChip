module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-products (SOP) form
assign out_sop = (a & ~b & ~c & ~d) | // 0
                (~a & b & ~c & ~d) | // 1
                (a & b & ~c & d) | // 2
                (a & b & c & d); // 7, 15

// Product-of-sums (POS) form
assign out_pos = (~a | ~b | c | d) & // 0, 1, 4, 5, 6, 9, 10, 13, 14
                (a | ~b | ~c | ~d) & // 0, 2, 4, 6, 7, 8, 11, 12, 15
                (~a | b | ~c | ~d); // 0, 1, 2, 5, 7, 9, 13, 14, 15

endmodule
