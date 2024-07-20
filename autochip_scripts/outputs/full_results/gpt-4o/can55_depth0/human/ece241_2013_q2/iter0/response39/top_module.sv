module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) form
    // The logic-1 conditions are for 2, 7, and 15.
    // 2  -> 0010
    // 7  -> 0111
    // 15 -> 1111
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Product-of-Sums (POS) form
    // The logic-0 conditions are for 0, 1, 4, 5, 6, 9, 10, 13, and 14.
    // 0  -> 0000
    // 1  -> 0001
    // 4  -> 0100
    // 5  -> 0101
    // 6  -> 0110
    // 9  -> 1001
    // 10 -> 1010
    // 13 -> 1101
    // 14 -> 1110
    assign out_pos = (a | b | c | d) & (a | b | c | ~d) & (a | b | ~c | d) & (a | b | ~c | ~d) &
                     (a | ~b | c | ~d) & (~a | b | c | d) & (~a | b | ~c | d) & (~a | ~b | c | d) &
                     (~a | ~b | c | ~d);

endmodule
