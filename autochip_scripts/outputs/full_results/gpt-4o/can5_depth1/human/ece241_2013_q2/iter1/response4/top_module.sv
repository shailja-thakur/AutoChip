module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Corrected Sum-of-Products (SOP) for generating output out_sop
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     (~a & b & c & d)   | // 7
                     (a & b & c & d);     // 15

    // Corrected Product-of-Sums (POS) for generating output out_pos
    assign out_pos = (a | ~b | ~c | ~d) & // 2
                     (~a | ~b | c | d) &  // 7
                     (a | b | c | d);     // 15

endmodule
