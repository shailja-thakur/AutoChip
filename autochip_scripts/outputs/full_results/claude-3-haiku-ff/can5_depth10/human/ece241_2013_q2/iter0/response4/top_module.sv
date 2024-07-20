module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// SOP (Sum of Products) expression
assign out_sop = (a & ~b & ~c & ~d) // 0
               | (~a & b & ~c & ~d) // 1
               | (~a & ~b & c & ~d) // 4
               | (~a & ~b & ~c & d) // 5
               | (~a & ~b & ~c & ~d) // 6
               | (a & b & c & ~d) // 7
               | (a & b & ~c & d) // 9
               | (a & ~b & c & d) // 10
               | (~a & b & c & d); // 13

// POS (Product of Sums) expression
assign out_pos = (~a | ~b | c | d) // 0, 1, 4, 5
                & (a | ~b | ~c | ~d) // 0, 2, 4, 6
                & (~a | b | ~c | ~d) // 1, 3, 5, 7
                & (a | b | ~c | d); // 7, 9, 10, 15

endmodule
