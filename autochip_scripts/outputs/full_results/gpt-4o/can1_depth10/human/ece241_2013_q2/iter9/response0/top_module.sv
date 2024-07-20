module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-of-Products (SOP) form
    assign out_sop = (~a & ~b & c & ~d) |   // 2 (0010)
                     (~a & b & c & d) |     // 7 (0111)
                     (a & b & c & d);       // 15 (1111)

    // Minimum Product-of-Sums (POS) form
    assign out_pos = (a | b | c | ~d) &     // Covers number 14 (1110)
                     (a | ~b | ~c | ~d) &    // Covers number 7 (0111)
                     (~a | b | d) &         // Covers number 13 (1101)
                     (~a | c | d) &         // Covers number 9 (1001)
                     (b | ~c | d) &         // Covers number 2 (0010)
                     (a | b | ~c) &         // Covers number 10 (1010)
                     (a | ~c | ~d) &        // Covers number 6 (0110)
                     (~a | ~b | ~d);        // Covers the rest: 0, 1, 4, 5

endmodule
