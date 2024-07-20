module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-products form for the conditions where the output is 1: (2, 7, 15)
    assign out_sop = (~a & ~b & c & ~d)    // 2
                   | (~a & b & c & d)      // 7
                   | (a & b & c & d);      // 15

    // Product-of-sums form for the conditions where the output is 0: (0, 1, 4, 5, 6, 9, 10, 13, 14)
    assign out_pos = (a | b | c | ~d)      // NOT 15
                   & (a | b | ~c | ~d)     // NOT 7
                   & (~a | ~b | c | ~d);   // NOT 2

endmodule
