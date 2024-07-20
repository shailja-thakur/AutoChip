module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products (SOP) form
assign out_sop =
    (~a & ~b & ~c & ~d) | // 0
    (~a & ~b & c & ~d) | // 2
    (a & b & c & d) | // 7
    (a & b & c & ~d); // 15

// Product-of-Sums (POS) form
assign out_pos =
    (~a | ~b | ~c | ~d) & // 0, 1, 3, 8, 11, 12
    (~a | ~b | c | d) & // 2, 3, 6, 7, 10, 11, 14, 15
    (~a | b | ~c | d) & // 1, 3, 5, 7, 9, 11, 13, 15
    (a | ~b | ~c | d) & // 4, 5, 8, 9, 12, 13
    (a | ~b | c | ~d) & // 2, 3, 6, 7, 10, 11, 14, 15
    (a | b | ~c | ~d); // 8, 12, 13, 14
endmodule
