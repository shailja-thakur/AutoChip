module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products (SOP) form
assign out_sop = (a & ~b & ~c & ~d) | // 0
                (~a & b & ~c & ~d) | // 1
                (~a & ~b & c & ~d) | // 4
                (~a & ~b & ~c & d) | // 5
                (~a & ~b & d & c) | // 6
                (a & b & c & d); // 15

// Product-of-Sums (POS) form
assign out_pos = (~a | ~b | c | d) & // 0, 1, 4, 5, 6, 15
                 (a | ~b | ~c | ~d) & // 0, 2, 7, 15
                 (a | b | ~c | ~d) & // 0, 1, 2, 3, 7, 15
                 (a | b | c | ~d); // 0, 1, 2, 3, 7, 8, 15

endmodule
