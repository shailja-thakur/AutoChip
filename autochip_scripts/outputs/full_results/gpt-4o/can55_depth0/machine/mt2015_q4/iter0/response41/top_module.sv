module top_module(
    input x,
    input y,
    output z);

    wire a1, a2, a3;

    // First gate: AND gate
    and g1(a1, x, y);

    // Second gate: OR gate
    or g2(a2, y, x);

    // Third gate: XOR gate
    xor g3(z, a1, a2);

endmodule
