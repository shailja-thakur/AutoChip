module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Minimum Sum-of-Products (SOP) form
assign out_sop = ((!a) & (!b) & (!c) & d) // 2
               | (a & b & c) // 7
               | (a & b & c & d); // 15

// Minimum Product-of-Sums (POS) form
assign out_pos = ((!a) | (!b) | (!c) | d) // 0, 1, 4, 5, 6, 9, 10, 13, 14
                & (a | (!b) | (!c) | (!d)) // 0, 2, 3, 4, 8, 12
                & (a | b | (!c) | (!d)) // 0, 1, 2, 3, 5, 7, 11, 13
                & (a | b | c | (!d)); // 0, 1, 2, 3, 6, 7, 15

endmodule
