module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-products form for the conditions where the output is 1: (2, 7, 15)
// Simplified using Karnaugh maps or Boolean algebra
// 2: a=0, b=0, c=1, d=0
// 7: a=0, b=1, c=1, d=1
// 15: a=1, b=1, c=1, d=1
assign out_sop = (~a & ~b & c & ~d)  // 2
               | (~a & b & c & d)    // 7
               | (a & b & c & d);    // 15

// Product-of-sums form for the conditions where the output is 0: (0, 1, 4, 5, 6, 9, 10, 13, 14)
// Simplified using Karnaugh maps or Boolean algebra
// 0: a=0, b=0, c=0, d=0
// 1: a=0, b=0, c=0, d=1
// 4: a=0, b=1, c=0, d=0
// 5: a=0, b=1, c=0, d=1
// 6: a=0, b=1, c=1, d=0
// 9: a=1, b=0, c=0, d=1
// 10: a=1, b=0, c=1, d=0
// 13: a=1, b=1, c=0, d=1
// 14: a=1, b=1, c=1, d=0
assign out_pos = (a | b | c | d)     // 0
               & (a | b | c | ~d)    // 1
               & (a | ~b | c | d)    // 4
               & (a | ~b | c | ~d)   // 5
               & (a | ~b | ~c | d)   // 6
               & (~a | b | c | ~d)   // 9
               & (~a | b | ~c | d)   // 10
               & (~a | ~b | c | ~d)  // 13
               & (~a | ~b | ~c | d); // 14

endmodule
