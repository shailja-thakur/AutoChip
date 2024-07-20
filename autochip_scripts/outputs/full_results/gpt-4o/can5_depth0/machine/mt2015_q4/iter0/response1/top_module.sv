module top_module(
    input x,
    input y,
    output z
);
    wire out1, out2;

    // First gate
    and g1(out1, x, y); // Using AND gate as the first gate

    // Second gate
    or g2(out2, y, x); // Using OR gate as the second gate

    // Third gate
    xor g3(z, out1, out2); // Using XOR gate as the third gate

endmodule
