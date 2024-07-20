module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // The user didn't specify the type of logic gates
    // Let's assume the logical sequence:
    // First gate: AND
    // Second gate: OR
    // Third gate: XOR

    and gate1(out1, x, y); // First gate
    or gate2(out2, y, x); // Second gate
    xor gate3(z, out1, out2); // Third gate

endmodule
