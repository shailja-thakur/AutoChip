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
    assign out_pos = (~a | ~b | ~c) &       // For 0, 1, 4, 5, 6, 9, 10, 13, 14
                     (~a | ~b | d) &        // Added to cover number 15 correctly
                     (~a | c | ~d) &        // For 9, 10
                     (~a | c | d) &         // For 1, 13
                     (~a | b | ~d) &        // For 1, 4, 5, 6, 14
                     (~a | b | c) &         // For 0, 4, 5, 6
                     (a | ~b | ~c | ~d) &   // For 7
                     (a | ~b | c | ~d) &    // For 9
                     (a | b | ~c | d) &     // For 2
                     (a | b | c | ~d);      // For 14

endmodule
