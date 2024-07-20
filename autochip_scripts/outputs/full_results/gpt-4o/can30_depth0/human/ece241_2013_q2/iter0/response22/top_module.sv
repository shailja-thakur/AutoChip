module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-of-Products (SOP) form for the given conditions
    assign out_sop = (~a & b & ~c & d) | // 2: 0010
                     (a & b & c & d)  | // 15: 1111
                     (a & b & c & ~d);  // 7: 0111

    // Minimum Product-of-Sums (POS) form for the given conditions
    assign out_pos = (a | ~b | c | ~d) & // 0, 1, 4, 5, 6, 9, 10, 13, 14
                     (a | b | c | d)    & // 7, 15 
                     (a | ~b | ~c | ~d) & // 2
                     (~a | ~b | ~c | ~d) & // 8, 9, 10, 11, 12, 14
                     (~a | ~b | ~c | d);    // 3

endmodule
