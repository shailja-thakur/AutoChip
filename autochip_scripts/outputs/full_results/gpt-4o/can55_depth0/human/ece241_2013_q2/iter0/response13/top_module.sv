module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-of-Products form (SO1P)
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     ( a &  b & c & d )  | // 15
                     (~a &  b & c & b);   // 7

    // Minimum Product-of-Sums form (POS)
    assign out_pos = (a | b | c | d) &   // 15
                     (a | ~b | c | d) & // 14
                     (~a | ~b | c | d); // 2

endmodule
