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
               | (~a & b & c & d) // 7
               | (a & b & c & d); // 15

// POS (Product of Sums) expression
assign out_pos = ~((a | b | c | d) // 0, 1, 4, 5, 6, 7, 15
                 & (a | ~b | c | d) // 0, 3, 5, 7, 11, 12, 15
                 & (a | b | ~c | d) // 0, 3, 6, 7, 8, 12, 15
                 & (a | b | c | ~d)); // 0, 3, 7, 8, 11, 13, 15
endmodule
