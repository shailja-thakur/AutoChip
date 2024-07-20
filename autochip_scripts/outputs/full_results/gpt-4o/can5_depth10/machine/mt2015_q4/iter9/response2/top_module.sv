module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Assume the following logic gates as per the pattern:
    // - First gate: AND
    // - Second gate: OR
    // - Third gate: XOR

    and gate1(out1, x, y); // First gate (AND)
    or gate2(out2, y, x); // Second gate (OR)
    xor gate3(z, out1, out2); // Third gate (XOR)

endmodule
