module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Forming the sum of products (SOP) for output out_sop
    assign out_sop = (~a & ~b & c & ~d) | // 2 (0010)
                     (~a & b & c & d)   | // 7 (0111)
                     (a & b & c & d);     // 15 (1111)

    // Forming the product of sums (POS) for output out_pos
    assign out_pos = (a | ~b | ~c | ~d) & // Covers the inverse of 2 (1110)
                     (a | ~b | ~c | d)  & // Covers the inverse of 7 (1000, 1010, 1100)
                     (~a | ~b | ~c | ~d) & // Covers the inverse of 15 (1110)
                     (a | b | ~c | ~d)  & // Covers the inverse of 4 (0100)
                     (a | b | ~c | d)   & // Covers the inverse of 5 (0110)
                     (a | ~b | c | ~d)  & // Covers the inverse of 6 (0110)
                     (a | b | c | ~d)   & // Covers the inverse of 9 (1001)
                     (a | ~b | c | d)   & // Covers the inverse of 10 (1010)
                     (a | b | ~c | c);  // Covers the inverse of 13 and 14 (1101 and 1110)

endmodule
