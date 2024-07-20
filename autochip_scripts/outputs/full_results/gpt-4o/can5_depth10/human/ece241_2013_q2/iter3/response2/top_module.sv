module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimized sum-of-products form
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     (~a & b & c & d)   | // 7
                     (a & b & c & d);   // 15
    
    // Minimized product-of-sums form
    assign out_pos = (~a | ~b | ~c | d)  & // Not 0 (covers 0, 1)
                     (~a | ~b | c | d)   & // Not 4 (covers 4)
                     (~a | b | ~c | ~d)  & // Not 5 (covers 5)
                     (~a | b | c | ~d)   & // Not 6 (covers 6)
                     (a | ~b | c | ~d)   & // Not 9 (covers 9)
                     (a | ~b | ~c | d)   & // Not 10 (covers 10)
                     (a | b | ~c | d)    & // Not 13 (covers 13)
                     (a | b | ~c | ~d);    // Not 14 (covers 14)

endmodule
