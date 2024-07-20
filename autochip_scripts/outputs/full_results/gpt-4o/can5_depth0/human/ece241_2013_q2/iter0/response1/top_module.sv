module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-of-Products form (SOP)
    assign out_sop = (~a & ~b & c & d) | (a & b & c & ~d) | (a & b & c & d);

    // Minimum Product-of-Sums form (POS)
    assign out_pos = (a | ~b | ~c | ~d) & (a | ~b | ~c | d) & (a | ~b | c | ~d);

endmodule
