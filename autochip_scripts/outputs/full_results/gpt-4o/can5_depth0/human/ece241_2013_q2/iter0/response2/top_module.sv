module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    // Sum-of-Products (SOP) expression for the given numbers 2, 7, 15
    assign out_sop = (~a & ~b & c & ~d) | // 2: 0010
                     ( a &  b & c & ~d) | // 7: 0111
                     ( a &  b & c &  d);  // 15: 1111

    // Product-of-Sums (POS) expression for the given assignments
    assign out_pos = ( a |  b | ~c |  d) & // for 0: 0000, 1: 0001, 4: 0100, 5: 0101, 6: 0110, 9: 1001, 10: 1010, 13: 1101, 14: 1110
                      (~a |  b | ~c |  d) & // for 0: 0000, 4: 0100, 8: 1000, 9: 1001, 12: 1100, 13: 1101
                      (~a | ~b |  c | ~d);  // for 2: 0010, 6: 0110, 10: 1010, 14: 1110

endmodule
