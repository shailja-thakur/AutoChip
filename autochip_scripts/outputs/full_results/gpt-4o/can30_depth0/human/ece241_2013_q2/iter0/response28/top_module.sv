module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    // Sum-of-products form (SOP)
    assign out_sop = (~a & ~b & c & d) | (a & b & c & ~d) | (a & b & c & d);

    // Product-of-sums form (POS)
    assign out_pos = (a | ~b | c) & (a | b | ~c) & (~a | ~b | d) & (~a | b | ~d);

endmodule
