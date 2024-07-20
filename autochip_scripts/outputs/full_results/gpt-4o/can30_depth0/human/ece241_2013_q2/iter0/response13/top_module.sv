module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) form: out_sop = (a' b' c d) + (a b c d) + (a b' c' d)
    assign out_sop = (~a & ~b & c & d) | (a & b & c & d) | (a & ~b & ~c & d);

    // Product-of-Sums (POS) form: out_pos = (a + c + d') (a + b' + c') (a' + b + c')
    assign out_pos = (a | c | ~d) & (a | ~b | ~c) & (~a | b | ~c);

endmodule
