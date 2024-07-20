module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    // Intermediate wires
    wire intermediate_1;
    wire intermediate_2;

    // First layer AND gates
    and gate_1 (intermediate_1, a, b);
    and gate_2 (intermediate_2, c, d);

    // Second layer OR gate
    or gate_3 (out, intermediate_1, intermediate_2);

    // Inverter
    not gate_4 (out_n, out);

endmodule
