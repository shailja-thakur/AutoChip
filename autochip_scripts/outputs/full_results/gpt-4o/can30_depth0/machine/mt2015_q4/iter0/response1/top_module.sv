module top_module(
    input x,
    input y,
    output z);

    wire n1, n2;

    // First gate
    and g1(n1, x, y);

    // Second gate
    or g2(n2, y, x);

    // Third gate
    xor g3(z, n1, n2);

endmodule
