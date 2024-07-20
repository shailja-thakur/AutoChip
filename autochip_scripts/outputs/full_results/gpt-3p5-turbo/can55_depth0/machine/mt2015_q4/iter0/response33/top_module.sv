module top_module(
    input x,
    input y,
    output z);

    wire a, b;

    // First gate
    and gate1 (x, y, a);

    // Second gate
    and gate2 (y, x, b);

    // Third gate
    or gate3 (a, b, z);
endmodule
