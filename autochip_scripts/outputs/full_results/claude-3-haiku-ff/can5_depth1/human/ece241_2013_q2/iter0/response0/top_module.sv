module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-products (SOP) form
assign out_sop = (a & ~b & ~c & ~d) // 0
                | (~a & b & ~c & ~d) // 1
                | (~a & ~b & c & ~d) // 4
                | (~a & ~b & ~c & d) // 5
                | (~a & ~b & ~c & ~d) // 6
                | (a & b & c & ~d) // 7
                | (a & b & c & d); // 15

// Product-of-sums (POS) form
wire w1 = ~a | b | c | d; // 0, 1, 4, 5, 6, 7, 9, 10, 13, 14, 15
wire w2 = a | ~b | ~c | ~d; // 0, 2, 3, 8, 11, 12, 13, 14, 15
wire w3 = ~a | ~b | c | ~d; // 0, 1, 4, 5, 6, 7, 11, 12, 13, 14, 15
wire w4 = ~a | ~b | ~c | d; // 0, 1, 4, 5, 6, 7, 9, 10, 12, 14, 15
assign out_pos = w1 & w2 & w3 & w4;

endmodule
