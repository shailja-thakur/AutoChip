module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND)
    and u1 (out1, x, y);

    // Second gate (OR)
    or u2 (out2, x, y);

    // Third gate (XOR)
    xor u3 (z, out1, out2);

endmodule
