module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First logic gate (AND gate used as an example)
    and first_gate(out1, x, y);

    // Second logic gate (OR gate used as an example)
    or second_gate(out2, y, x);

    // Third logic gate (XOR gate used as an example)
    xor third_gate(z, out1, out2);

endmodule
