module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire and_out_1, and_out_2, or_out;

    // First layer of AND gates
    and(and_out_1, a, b);
    and(and_out_2, c, d);

    // Second layer of OR gate
    or(or_out, and_out_1, and_out_2);

    // Assign outputs
    assign out = or_out;
    assign out_n = ~out;

endmodule
