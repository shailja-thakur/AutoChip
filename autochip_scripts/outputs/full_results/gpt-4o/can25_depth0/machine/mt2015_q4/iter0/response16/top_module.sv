module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First logic gate (AND gate for example)
    and gate1 (out1, x, y);

    // Second logic gate (OR gate for example)
    or gate2 (out2, y, x);

    // Third logic gate (XOR gate for example)
    xor gate3 (z, out1, out2);

endmodule
