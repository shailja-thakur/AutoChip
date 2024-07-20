module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of Products (SOP)
    // Logic-1 for 2, 7, 15
    // 2: 0010 -> a'b'cd'
    // 7: 0111 -> a'bc'd
    // 15: 1111 -> abcd
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Product of Sums (POS)
    // Logic-0 for 0, 1, 4, 5, 6, 9, 10, 13, 14
    // 0: 0000 -> (a + b + c + d)
    // 1: 0001 -> (a + b + c + d')
    // 4: 0100 -> (a + b' + c + d)
    // 5: 0101 -> (a + b' + c + d')
    // 6: 0110 -> (a + b' + c' + d)
    // 9: 1001 -> (a' + b + c + d')
    // 10: 1010 -> (a' + b + c' + d)
    // 13: 1101 -> (a' + b' + c + d')
    // 14: 1110 -> (a' + b' + c' + d)
    assign out_pos = (a | b | c | d) & (a | b | c | ~d) & (a | ~b | c | d) & (a | ~b | c | ~d) &
                     (a | ~b | ~c | d) & (~a | b | c | ~d) & (~a | b | ~c | d) &
                     (~a | ~b | c | ~d) & (~a | ~b | ~c | d);

endmodule
