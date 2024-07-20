module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-products form for the conditions where the output is 1: (2, 7, 15)
    // 2: a=0, b=0, c=1, d=0
    // 7: a=0, b=1, c=1, d=1
    // 15: a=1, b=1, c=1, d=1
    assign out_sop = (a & b & c & d)   // 15
                   | (~a & b & c & d)  // 7
                   | (~a & ~b & c & ~d); // 2

    // Product-of-sums form for the conditions where the output is 0: (0, 1, 4, 5, 6, 9, 10, 13, 14)
    // These can be written in POS as:
    assign out_pos = (a | ~c | ~d)    // 1, 9, 10, 13
                   & (b | ~c | d)     // 0, 4, 5, 10
                   & (a | ~b | ~d)    // 0, 1, 4, 5
                   & (a | ~c | d)     // 6, 9, 13, 14
                   & (~b | ~c | d);   // 5, 6, 1, 13, 9

endmodule
