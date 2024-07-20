module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND gate for example)
    and g1 (out1, x, y);

    // Second gate (OR gate for example)
    or g2 (out2, y, x);

    // Third gate (XOR gate for example)
    xor g3 (z, out1, out2);

endmodule
