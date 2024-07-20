module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// SOP (Sum of Products) form
assign out_sop = (a & ~b & ~c & ~d) | // 2
                (~a & b & c & d) | // 7
                (a & b & c & d); // 15

// POS (Product of Sums) form
assign out_pos = (~a | ~b | ~c | ~d) & // 0, 1, 3, 8, 11, 12
                 (a | ~b | ~c | ~d) & // 1, 3, 9, 11, 12
                 (a | b | ~c | ~d) & // 4
                 (a | b | c | ~d) & // 5
                 (a | b | c | d) & // 6, 7, 15
                 (~a | b | ~c | ~d) & // 9, 10
                 (~a | b | ~c | d) & // 10
                 (~a | ~b | ~c | d) & // 13
                 (~a | ~b | c | ~d); // 14

endmodule
