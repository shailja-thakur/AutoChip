module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of products (SOP) form derived from the given conditions: 2, 7, 15
    // 2: 0010 (a = 0, b = 0, c = 1, d = 0)
    // 7: 0111 (a = 0, b = 1, c = 1, d = 1)
    // 15: 1111 (a = 1, b = 1, c = 1, d = 1)
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Product of sums (POS) form derived from the given conditions: 0, 1, 4, 5, 6, 9, 10, 13, 14
    // 0: 0000 (a = 0, b = 0, c = 0, d = 0)
    // 1: 0001 (a = 0, b = 0, c = 0, d = 1)
    // 4: 0100 (a = 0, b = 1, c = 0, d = 0)
    // 5: 0101 (a = 0, b = 1, c = 0, d = 1)
    // 6: 0110 (a = 0, b = 1, c = 1, d = 0)
    // 9: 1001 (a = 1, b = 0, c = 0, d = 1)
    // 10: 1010 (a = 1, b = 0, c = 1, d = 0)
    // 13: 1101 (a = 1, b = 1, c = 0, d = 1)
    // 14: 1110 (a = 1, b = 1, c = 1, d = 0)
    assign out_pos = (a | b | c | d) &
                     (a | b | c | ~d) &
                     (a | b | ~c | d) &
                     (a | b | ~c | ~d) &
                     (a | ~b | c | d) &
                     (a | ~b | c | ~d) &
                     (a | ~b | ~c | d) &
                     (~a | b | c | d) &
                     (~a | b | c | ~d) &
                     (~a | b | ~c | d) &
                     (~a | ~b | c | ~d) &
                     (~a | ~b | ~c | ~d);

endmodule
