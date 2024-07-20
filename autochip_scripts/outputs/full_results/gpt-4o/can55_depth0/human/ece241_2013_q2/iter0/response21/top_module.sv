module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) for 2, 7, and 15
    // 2  -> 0010
    // 7  -> 0111
    // 15 -> 1111
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     (~a & b & c & d)   | // 7
                     (a & b & c & d);     // 15

    // Product-of-Sums (POS) for 0, 1, 4, 5, 6, 9, 10, 13, 14
    // 0  -> 0000
    // 1  -> 0001
    // 4  -> 0100
    // 5  -> 0101
    // 6  -> 0110
    // 9  -> 1001
    // 10 -> 1010
    // 13 -> 1101
    // 14 -> 1110
    assign out_pos = (a | b | c | d) & // 0
                     (a | b | c | ~d) & // 1
                     (a | ~b | c | d) & // 4
                     (a | ~b | c | ~d) & // 5
                     (a | ~b | ~c | d) & // 6
                     (~a | b | c | ~d) & // 9
                     (~a | b | ~c | d) & // 10
                     (~a | ~b | c | ~d) & // 13
                     (~a | ~b | ~c | d); // 14

endmodule
