module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of products (SOP) form for out_sop
    // out_sop should be high when the input is 2, 7, or 15
    // 2  -> 0010
    // 7  -> 0111
    // 15 -> 1111
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Product of sums (POS) form for out_pos
    // out_pos should be low when the input is 0, 1, 4, 5, 6, 9, 10, 13, 14
    // The complemented function covers the same sets, so the out_sol function can be
    // synthesized by negating the product of sums form
    assign out_pos = (~a | b | ~c | d) & (a | b | ~c | d) & (a | ~b | ~c | d) & (a | b | c | ~d);

endmodule
