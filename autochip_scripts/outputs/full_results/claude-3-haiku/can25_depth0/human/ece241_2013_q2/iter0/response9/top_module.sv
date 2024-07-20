module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products (SOP) form
assign out_sop = (a & ~b & ~c & ~d) | // 0
                (~a & b & ~c & ~d) | // 1
                (~a & ~b & c & ~d) | // 4
                (~a & ~b & ~c & d) | // 5
                (~a & ~b & d & d) | // 6
                (a & b & c & ~d) | // 7
                (a & b & d & d); // 15

// Product-of-Sums (POS) form
wire w1, w2, w3, w4, w5, w6, w7, w8, w9;
assign w1 = ~a | b | c | d; // 0
assign w2 = a | ~b | c | d; // 1
assign w3 = a | b | ~c | d; // 4
assign w4 = a | b | c | ~d; // 5
assign w5 = a | b | ~c | ~d; // 6
assign w6 = ~a | ~b | ~c | d; // 7
assign w7 = ~a | ~b | c | ~d; // 9
assign w8 = ~a | b | ~c | ~d; // 10
assign w9 = a | ~b | ~c | ~d; // 13
assign out_pos = (w1 & w2 & w3 & w4 & w5) | (w6 & w7 & w8 & w9);

endmodule
