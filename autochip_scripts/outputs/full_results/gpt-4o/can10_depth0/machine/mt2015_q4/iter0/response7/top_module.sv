module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate
    and and_gate1(out1, x, y);

    // Second gate
    or or_gate2(out2, y, x);

    // Third gate
    xor xor_gate3(z, out1, out2);

endmodule
