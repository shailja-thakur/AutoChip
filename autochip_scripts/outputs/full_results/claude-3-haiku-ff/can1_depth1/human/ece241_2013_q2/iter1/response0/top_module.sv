module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products (SOP) form
assign out_sop = ((~a) & (~b) & (~c) & (~d)) // 0
               | ((~a) & (~b) & c & (~d)) // 1
               | ((a) & (~b) & (~c) & d) // 3
               | ((~a) & b & (~c) & (~d)) // 4
               | ((~a) & b & c & (~d)) // 5
               | ((~a) & b & (~c) & d) // 6
               | ((a) & (~b) & c & d); // 7

// Product-of-Sums (POS) form
assign out_pos = (a | b | c | d) // 0, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
                 & (~a | ~b | ~c) // 0, 1, 2, 3, 4, 5, 6, 7
                 & (~a | ~b | d) // 0, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
                 & (~a | c | ~d) // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
                 & (a | ~b | ~d); // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15

endmodule
