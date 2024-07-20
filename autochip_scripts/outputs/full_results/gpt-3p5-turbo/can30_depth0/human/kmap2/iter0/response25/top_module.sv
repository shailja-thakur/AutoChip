module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Intermediate signals
    wire w1, w2, w3, w4;

    // Implementing the Karnaugh map
    or #(4) u1 (out, w1, w2, w3, w4);
    and #(4) u2 (w1, a, b, not(c), not(d));
    and #(4) u3 (w2, a, not(b), not(c), not(d));
    and #(4) u4 (w3, not(a), b, c, not(d));
    and #(4) u5 (w4, a, b, not(c), d);

endmodule
