module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    // Intermediate wire declarations
    wire intermediate1;
    wire intermediate2;

    // First layer - two AND gates
    and gate1 (intermediate1, a, b);
    and gate2 (intermediate2, c, d);

    // Second layer - OR gate
    or gate3 (out, intermediate1, intermediate2);

    // Inverted output
    not gate4 (out_n, out);

endmodule
