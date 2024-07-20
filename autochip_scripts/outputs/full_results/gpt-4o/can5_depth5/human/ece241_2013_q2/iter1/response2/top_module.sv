module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum sum-of-products (SOP) form for detecting 2, 7, or 15.
    // 2: 0010 -> (~a & ~b & c & ~d)
    // 7: 0111 -> (a & b & c & d)
    // 15: 1111 -> (a & b & c & d)
    // We need to include 2 (0010) in the equations and merge terms.
    assign out_sop = (~a & b & ~c & d) | (b & c & d) | (~a & b & c & ~d);

    // Minimum product-of-sums (POS) form for detecting 0, 1, 4, 5, 6, 9, 10, 13, or 14.
    // For these values, the output should be 0. So we can take the complement of these terms.
    // (0: 0000), (1: 0001), (4: 0100), (5: 0101), (6: 0110), (9: 1001), (10: 1010), (13: 1101), (14: 1110)
    assign out_pos = (a | ~b | c | d) & (a | b | ~c | d) & (a | b | c | ~d) & (a | ~b | ~c | d)
                  & (~a | b | ~c | d) & (~a | c | ~d) & (~a | b | c | d);

endmodule
