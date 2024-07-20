module top_module(
    input x,
    input y,
    output z);

    wire g1_out, g2_out;

    // First gate: AND gate
    and g1(g1_out, x, y);

    // Second gate: OR gate
    or g2(g2_out, y, x);

    // Third gate: XOR gate
    xor g3(z, g1_out, g2_out);

endmodule
