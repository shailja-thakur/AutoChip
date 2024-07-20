module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire and_out1, and_out2;

    // First layer: AND gates
    and(and_out1, a, b);
    and(and_out2, c, d);

    // Second layer: OR gate
    or(out, and_out1, and_out2);

    // Inverted output
    not(out_n, out);

endmodule
