module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Minimum Sum-of-Products (SOP) form
assign out_sop = (a & ~b & ~c & ~d) | // 0
                (~a & b & ~c & ~d) | // 1
                (~a & ~b & c & ~d) | // 4
                (~a & ~b & ~c & d) | // 5
                (~a & ~b & c & d) | // 6
                (a & b & c & ~d) | // 7
                (a & ~b & c & d) | // 15
                (a & b & ~c & d); // 13

// Minimum Product-of-Sums (POS) form
assign out_pos = (~a | ~b | ~c | ~d) & // 0, 1, 4, 5, 6, 9, 10, 13, 14
                 (a | b | ~c | ~d) & // 0, 1, 3, 7, 11, 12, 15
                 (a | ~b | c | ~d) & // 0, 2, 3, 5, 6, 7, 8, 15
                 (a | b | c | ~d); // 0, 3, 7, 11, 12, 15

endmodule
