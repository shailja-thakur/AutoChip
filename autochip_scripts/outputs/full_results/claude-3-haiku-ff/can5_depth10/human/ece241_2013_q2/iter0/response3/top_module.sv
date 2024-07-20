module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products (SOP) expression for out_sop
assign out_sop = (a & ~b & ~c & ~d) // 2
               | (~a & b & b & ~d) // 7
               | (~a & ~b & c & d); // 15

// Product-of-Sums (POS) expression for out_pos
assign out_pos = (~a | ~b | c | d) // 0, 1, 4, 5, 6, 9, 10, 13, 14
                 & (a | ~b | ~c | ~d) // 2, 7, 15
                 & (a | b | ~c | ~d); // 2, 3, 7, 11, 12, 13, 14, 15

endmodule
