module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire and1_out;
    wire and2_out;

    // First layer of AND gates
    and(and1_out, a, b);
    and(and2_out, c, d);

    // Second layer of OR gate
    or(out, and1_out, and2_out);

    // Inverted output
    not(out_n, out);

endmodule
