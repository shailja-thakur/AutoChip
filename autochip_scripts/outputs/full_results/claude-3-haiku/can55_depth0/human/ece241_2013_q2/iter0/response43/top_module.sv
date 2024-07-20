module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// SOP (Sum of Products) expression
assign out_sop = (~a & ~b & ~c & d) // 2
                | (a & ~b & c & d) // 7
                | (a & b & c & d); // 15

// POS (Product of Sums) expression
assign out_pos = (~a | ~b | ~c | d) // 0, 1, 4, 5, 6, 9, 10, 13, 14
                 & (a | ~b | ~c | ~d) // 0, 1, 2, 3, 5, 8, 9, 11, 12
                 & (~a | b | ~c | ~d) // 0, 2, 4, 6, 8, 10, 12, 14
                 & (~a | ~b | c | ~d); // 0, 1, 2, 3, 6, 7, 12, 13

endmodule
