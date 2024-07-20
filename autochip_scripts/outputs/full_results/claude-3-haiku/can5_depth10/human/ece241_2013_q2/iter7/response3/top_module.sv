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
    (~a | ~b | ~c | d) & // 0, 1, 4, 5, 6, 13, 14
    (~a | ~b | c | ~d) & // 2, 3, 10, 11
    (~a | b | ~c | ~d) & // 8, 9, 12, 15
    (a | b | c | d); // 7

endmodule
