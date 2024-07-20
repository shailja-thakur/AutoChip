module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First logic gate (AND gate)
    and g1 (out1, x, y);
    
    // Second logic gate (OR gate)
    or g2 (out2, y, x);
    
    // Third logic gate (XOR gate)
    xor g3 (z, out1, out2);

endmodule
