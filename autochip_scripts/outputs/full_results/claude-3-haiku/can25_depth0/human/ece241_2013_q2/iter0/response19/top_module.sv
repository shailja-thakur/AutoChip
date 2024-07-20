module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-products (SOP) form
assign out_sop = (a & b & ~c & ~d) | // 2
                (~a & b & c & d) | // 7
                (a & b & c & d);   // 15

// Product-of-sums (POS) form
assign out_pos = (~a | ~b | c | d) & // 0, 1, 4, 5, 6, 9, 10, 13, 14
                 (a | ~b | ~c | ~d) & // 0, 2, 4, 8, 12
                 (~a | b | ~c | ~d) & // 1, 5, 9, 13
                 (a | b | ~c | d);   // 3, 7, 11, 15
endmodule
