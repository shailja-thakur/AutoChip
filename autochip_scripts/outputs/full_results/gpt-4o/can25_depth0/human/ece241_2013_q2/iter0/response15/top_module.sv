module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of Products (SOP) for 2, 7, 15
    // 2  -> 0010 (a'bcd')
    // 7  -> 0111 (ab'cd)
    // 15 -> 1111 (abcd)
    assign out_sop = (~a & b & ~c & ~d) | (a & ~b & c & d) | (a & b & c & d);

    // Product of Sums (POS) for 0, 1, 4, 5, 6, 9, 10, 13, 14
    // 0  -> 0000
    // 1  -> 0001
    // 4  -> 0100
    // 5  -> 0101
    // 6  -> 0110
    // 9  -> 1001
    // 10 -> 1010
    // 13 -> 1101
    // 14 -> 1110
    assign out_pos = (a | ~b | c | d) & (a | b | ~c | d) & (a | b | c | ~d) & (~a | b | c | d);

endmodule
