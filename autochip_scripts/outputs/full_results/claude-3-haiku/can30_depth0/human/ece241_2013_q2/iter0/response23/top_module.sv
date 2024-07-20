module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products (SOP) form
assign out_sop = (~a & ~b & ~c & d) // 2
               | (a & b & c & ~d) // 7
               | (a & b & c & d); // 15

// Product-of-Sums (POS) form
wire term1, term2, term3;
assign term1 = ~a | ~b | ~c | d; // 2, 3, 6, 7, 11, 12, 13, 14, 15
assign term2 = ~a | ~b | c | ~d; // 1, 3, 4, 5, 9, 11, 12, 13
assign term3 = ~a | b | ~c | ~d; // 0, 3, 8, 11, 12
assign out_pos = term1 & term2 & term3; // 3, 11, 12
endmodule
