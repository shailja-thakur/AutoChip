module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire and1_out, and2_out;

    // First layer: two AND gates
    and u1 (and1_out, a, b);
    and u2 (and2_out, c, d);

    // Second layer: OR gate
    or u3 (out, and1_out, and2_out);

    // Inverted output
    not u4 (out_n, out);

endmodule
