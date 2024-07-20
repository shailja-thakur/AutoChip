module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// SOP (Sum of Products) form
assign out_sop = (~a & ~b & ~c & ~d) | // 0
                (~a & ~b & c & d) | // 7
                (a & b & c & d); // 15

// POS (Product of Sums) form
assign out_pos = (a | b | ~c | ~d) & // 0, 1, 4, 5, 6, 9, 10, 13, 14
                (~a | ~b | c | d) & // 7
                (~a | ~b | ~c | ~d); // 2
endmodule
