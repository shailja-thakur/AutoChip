module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND gate as an example)
    and gate1(out1, x, y);

    // Second gate (OR gate as an example)
    or gate2(out2, y, x);

    // Third gate (XOR gate as an example)
    xor gate3(z, out1, out2);

endmodule
