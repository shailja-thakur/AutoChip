module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum sum-of-products (SOP) form for out_sop
    assign out_sop = (~a & b & ~c & d) | (a & b & c & d) | (a & b & ~c & c);

    // Minimum product-of-sums (POS) form for out_pos
    assign out_pos = (a | ~b | c | ~d) & (a | ~b | ~c | ~d) & (~a | b | ~c | ~d);

endmodule
