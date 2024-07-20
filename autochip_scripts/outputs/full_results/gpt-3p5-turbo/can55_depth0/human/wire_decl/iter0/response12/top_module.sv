module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    // Intermediate wires to connect AND and OR gates
    wire and_out_1;
    wire and_out_2;

    // AND gates
    and gate1(and_out_1, a, b);
    and gate2(and_out_2, c, d);

    // OR gate
    or gate3(out, and_out_1, and_out_2);

    // Inverter
    not gate4(out_n, out);

endmodule
