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
wire out_pos_1 = ~a | ~b | ~c | ~d; // 0, 1, 4, 5, 6, 9, 10, 13, 14
wire out_pos_2 = a | ~b | ~c | d; // 5, 7, 15
wire out_pos_3 = a | b | ~c | ~d; // 3, 7, 11, 15
assign out_pos = out_pos_1 & out_pos_2 & out_pos_3;

endmodule
