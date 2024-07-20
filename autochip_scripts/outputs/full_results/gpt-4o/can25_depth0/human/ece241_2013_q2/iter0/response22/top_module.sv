module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum sum-of-products (SOP) form
    // Logic-1 when the inputs represent 2, 7, or 15
    // Decimal 2 -> 0010 (a=0, b=0, c=1, d=0)
    // Decimal 7 -> 0111 (a=0, b=1, c=1, d=1)
    // Decimal 15 -> 1111 (a=1, b=1, c=1, d=1)
    assign out_sop = (~a & ~b & c & ~d) |    // 2
                     (~a & b & c & d)   |    // 7
                     (a & b & c & d);        // 15

    // Minimum product-of-sums (POS) form
    // Logic-0 when the inputs represent 0, 1, 4, 5, 6, 9, 10, 13, or 14
    // Decimal 0  -> 0000 (a=0, b=0, c=0, d=0)
    // Decimal 1  -> 0001 (a=0, b=0, c=0, d=1)
    // Decimal 4  -> 0100 (a=0, b=1, c=0, d=0)
    // Decimal 5  -> 0101 (a=0, b=1, c=0, d=1)
    // Decimal 6  -> 0110 (a=0, b=1, c=1, d=0)
    // Decimal 9  -> 1001 (a=1, b=0, c=0, d=1)
    // Decimal 10 -> 1010 (a=1, b=0, c=1, d=0)
    // Decimal 13 -> 1101 (a=1, b=1, c=0, d=1)
    // Decimal 14 -> 1110 (a=1, b=1, c=1, d=0)
    assign out_pos = (a | b | c | d) &       // 0
                     (a | b | c | ~d) &      // 1
                     (a | ~b | c | d) &      // 4
                     (a | ~b | c | ~d) &     // 5
                     (a | ~b | ~c | d) &     // 6
                     (~a | b | c | d) &      // 9
                     (~a | b | c | ~d) &     // 10
                     (~a | ~b | c | d) &     // 13
                     (~a | ~b | c | ~d);     // 14

endmodule
