module top_module(
    input x,
    input y,
    output z);

    wire a, b;

    // First gate
    and gate1(x, y, a);

    // Second gate
    or gate2(x, y, b);

    // Third gate
    xor gate3(a, b, z);

endmodule
