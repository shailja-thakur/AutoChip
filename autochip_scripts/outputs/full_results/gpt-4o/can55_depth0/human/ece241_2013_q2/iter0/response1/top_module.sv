module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-of-Products (SOP) form
    assign out_sop = (~a & ~b & c & ~d) |  // 2 (0010)
                     (~a & b & c & d)  |   // 7 (0111)
                     (a & b & c & d);      // 15 (1111)

    // Minimum Product-of-Sums (POS) form
    assign out_pos = (a | b | ~c | d) &
                     (a | ~b | ~c | ~d) &
                     (~a | ~b | c | ~d);

endmodule
