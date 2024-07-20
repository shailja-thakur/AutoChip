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
assign out_pos = (~a | ~b | ~c | ~d) & // 0
                 (a | ~b | ~c | ~d) & // 1
                 (a | b | ~c | ~d) & // 4
                 (a | b | c | ~d) & // 5
                 (a | b | c | d) & // 6
                 (~a | ~b | c | d) & // 8
                 (~a | b | ~c | d) & // 9
                 (~a | b | c | ~d) & // 10
                 (~a | ~b | ~c | d) & // 13
                 (~a | ~b | c | ~d); // 14

endmodule
