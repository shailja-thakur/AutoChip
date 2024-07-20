module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Minimum Sum-of-Products (SOP) form
assign out_sop = (~a & ~b & c & d) // 2
               | (a & b & c & ~d) // 7
               | (a & b & c & d); // 15

// Minimum Product-of-Sums (POS) form
assign out_pos = (~a | ~b | ~c) & (a | b | ~c | ~d) // 0, 1, 4, 5, 6, 13, 14
                & (~a | b | ~c | d) // 9, 10
                & (a | ~b | ~c | ~d); // 0

endmodule
