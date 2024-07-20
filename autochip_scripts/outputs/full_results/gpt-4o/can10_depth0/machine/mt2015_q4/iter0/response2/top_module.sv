module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;
    
    // First gate
    and g1 (out1, x, y);

    // Second gate
    or g2 (out2, y, x);

    // Third gate
    xor g3 (z, out1, out2);

endmodule
