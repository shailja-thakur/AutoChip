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
wire w1 = ~a | ~b | ~c | ~d; // 0, 1, 4, 5, 6, 9, 10, 13, 14
wire w2 = ~a | b | ~c | ~d; // 1, 3, 5, 9, 11, 13
wire w3 = a | ~b | ~c | d; // 2, 3, 6, 7, 10, 11, 14, 15
assign out_pos = w1 | w2 | w3;

endmodule
