module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Truth table:
    // a b c d | out_sop
    // 0 0 0 0 | 0
    // 0 0 0 1 | 0
    // 0 0 1 0 | 1 (2)
    // 0 0 1 1 | 0
    // 0 1 0 0 | 0
    // 0 1 0 1 | 0
    // 0 1 1 0 | 0
    // 0 1 1 1 | 1 (7)
    // 1 0 0 0 | 0
    // 1 0 0 1 | 0
    // 1 0 1 0 | 0
    // 1 0 1 1 | 0
    // 1 1 0 0 | 0
    // 1 1 0 1 | 0
    // 1 1 1 0 | 0
    // 1 1 1 1 | 1 (15)

    // Sum-of-Products (SOP) form for the conditions 2, 7, 15
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Product-of-Sums (POS) form for the conditions 0, 1, 4, 5, 6, 9, 10, 13, 14
    assign out_pos = (a | b | c | ~d) & (a | b | ~c | d) & (a | b | ~c | ~d) & (a | ~b | c | d) & (a | ~b | c | ~d) & (~a | b | c | d) & (~a | b | c | ~d) & (~a | ~b | c | ~d) & (~a | b | ~c | d);

endmodule
