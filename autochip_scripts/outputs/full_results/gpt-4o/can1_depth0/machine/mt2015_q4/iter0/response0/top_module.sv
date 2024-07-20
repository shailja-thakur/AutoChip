module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First logic gate (AND gate)
    and gate1 (out1, x, y);

    // Second logic gate (OR gate)
    or gate2 (out2, y, x);

    // Third logic gate (XOR gate)
    xor gate3 (z, out1, out2);

endmodule
