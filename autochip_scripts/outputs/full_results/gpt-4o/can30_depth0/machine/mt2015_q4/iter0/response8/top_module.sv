module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate
    and and1(out1, x, y);

    // Second gate
    or or1(out2, y, x);

    // Third gate
    xor xor1(z, out1, out2);

endmodule
