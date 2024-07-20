module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Minimum sum-of-products (SOP) form
assign out_sop = (a & ~b & ~c & ~d) // 2
               | (~a & b & c & d)  // 7
               | (a & b & c & d);   // 15

// Minimum product-of-sums (POS) form
assign out_pos = (~a | ~b | ~c | ~d) // 0, 1, 4, 5, 6, 9, 10, 13, 14
                & (a | ~b | ~c | ~d) // 0, 1, 2, 3, 8, 9, 11, 12, 13
                & (~a | b | ~c | ~d) // 0, 2, 4, 6, 8, 10, 12, 14, 15
                & (~a | ~b | c | ~d); // 0, 1, 4, 5, 7, 9, 11, 13, 15

endmodule
