module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire and1_out, and2_out, or_out;

    // Layer 1: AND gates
    and(and1_out, a, b);
    and(and2_out, c, d);

    // Layer 2: OR gate
    or(or_out, and1_out, and2_out);

    // Outputs
    assign out = or_out;
    assign out_n = ~out;

endmodule
