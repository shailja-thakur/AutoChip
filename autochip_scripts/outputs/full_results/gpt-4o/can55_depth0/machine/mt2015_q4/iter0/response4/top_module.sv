module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate
    and u1 (out1, x, y);

    // Second gate
    or u2 (out2, y, x);

    // Third gate
    xor u3 (z, out1, out2);

endmodule
