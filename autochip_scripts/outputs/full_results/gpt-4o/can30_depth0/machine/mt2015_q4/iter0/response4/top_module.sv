module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;

    // Instantiation of the first gate (AND gate)
    and g1(out1, x, y);

    // Instantiation of the second gate (OR gate)
    or g2(out2, y, x);

    // Instantiation of the third gate (XOR gate)
    xor g3(z, out1, out2);

endmodule
