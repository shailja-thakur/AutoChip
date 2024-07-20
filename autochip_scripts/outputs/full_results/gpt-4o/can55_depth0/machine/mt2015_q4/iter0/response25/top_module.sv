module top_module(
    input x,
    input y,
    output z);

    wire out1; // Output of the first gate
    wire out2; // Output of the second gate

    // First gate (e.g., AND gate)
    and gate1(out1, x, y);

    // Second gate (e.g., OR gate)
    or gate2(out2, y, x);

    // Third gate (e.g., XOR gate)
    xor gate3(z, out1, out2);

endmodule
