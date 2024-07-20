module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimal Sum-of-Products (SOP) form for the numbers 2, 7, and 15
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Minimal Product-of-Sums (POS) form for the complement of the numbers 0, 1, 4, 5, 6, 9, 10, 13, and 14
    assign out_pos = (a | b | ~c | d) & (a | ~b | c | d) & (a | ~b | c | ~d);

endmodule
