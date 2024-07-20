module top_module(
    input x,
    input y,
    output z
);
    wire out1, out2; // Intermediate wires between gates

    and gate1(out1, x, y);  // First gate (AND gate): a = x, b = y
    or gate2(out2, y, x);   // Second gate (OR gate): a = y, b = x
    xor gate3(z, out1, out2); // Third gate (XOR gate): a = out1, b = out2

endmodule
