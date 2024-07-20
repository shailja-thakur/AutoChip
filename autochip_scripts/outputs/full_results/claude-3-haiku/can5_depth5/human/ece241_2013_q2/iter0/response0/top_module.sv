module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products form
assign out_sop = (~a & ~b & ~c & ~d) // 0
                | (a & ~b & ~c & d) // 2
                | (a & b & c & d); // 15

// Product-of-Sums form
assign out_pos = (~a | ~b | ~c | ~d) // 0, 1, 4, 5, 6, 9, 10, 13, 14
                & (a | ~b | ~c | d) // 2, 7, 15
                & (~a | b | ~c | ~d) // 0, 1, 2, 5, 7, 13, 15
                & (a | b | ~c | d); // 2, 7, 15
endmodule
