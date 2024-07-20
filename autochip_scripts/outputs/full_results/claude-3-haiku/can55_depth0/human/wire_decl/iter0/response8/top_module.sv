module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire and1, and2;

    // First layer of AND gates
    and(and1, a, b);
    and(and2, c, d);

    // Second layer of OR gate
    or(out, and1, and2);

    // Inverted output
    not(out_n, out);

endmodule
