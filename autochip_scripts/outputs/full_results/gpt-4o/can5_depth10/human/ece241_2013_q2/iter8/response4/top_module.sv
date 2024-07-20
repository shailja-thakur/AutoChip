module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Compute output in minimized sum-of-products form
    assign out_sop = ( ~a & ~b & c & ~d  // 2
                     || ~a & b & c & d   // 7
                     || a & b & c & d);  // 15

    // Compute output in minimized product-of-sums form
    assign out_pos = ( a | b | ~c | d    // complement 2: (a ∨ b ∨ ˉc ∨ d)
                     && a | ~b | ~c | ~d // complement 7: (a ∨ ˉb ∨ ˉc ∨ ˉd)
                     && ~a | ~b | ~c | ~d// complement 15: (ˉa ∨ ˉb ∨ ˉc ∨ ˉd)
                     && a | ~b | ~c | d  // complement 1: (a ∨ ˉb ∨ ˉc ∨ d)
                     && a | ~b | c | d   // complement 5: (a ∨ ˉb ∨ c ∨ d)
                     && ~a | b | ~c | d  // complement 9: (ˉa ∨ b ∨ ˉc ∨ d)
                     && ~a | b | c | d   // complement 13: (ˉa ∨ b ∨ c ∨ d)
                     && a | b | c | ~d  // complement 14: (a ∨ b ∨ c ∨ ˉd)
                     && ~a | b | c | ~d   // complement 6: (ˉa ∨ b ∨ c ∨ ˉd)
                     );

endmodule
