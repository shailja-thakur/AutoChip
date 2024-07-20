module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products (SOP) form
assign out_sop = (a & ~b & ~c & ~d) // 0
               | (~a & b & ~c & ~d) // 1
               | (~a & ~b & c & ~d) // 4
               | (~a & ~b & ~c & d) // 5
               | (~a & ~b & ~c & ~d) // 6
               | (~a & b & c & d) // 7
               | (a & b & c & d); // 15

// Product-of-Sums (POS) form
wire term1 = ~a | ~b | ~c | ~d; // 0, 1, 4, 5, 6, 9, 10, 13, 14
wire term2 = a | ~b | ~c | ~d; // 0, 3, 5, 7, 11, 12, 15
wire term3 = ~a | b | ~c | ~d; // 1, 3, 6, 7, 9, 11, 15
wire term4 = ~a | ~b | c | ~d; // 4, 5, 6, 7, 12, 13, 15
wire term5 = ~a | ~b | ~c | d; // 5, 6, 7, 10, 12, 14, 15
assign out_pos = (term1 & term2 & term3 & term4 & term5); // 0, 1, 4, 5, 6, 7, 15

endmodule
