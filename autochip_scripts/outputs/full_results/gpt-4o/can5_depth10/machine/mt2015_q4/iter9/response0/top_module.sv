module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Assuming first gate is AND gate
    and gate1(out1, x, y); // First gate

    // Assuming second gate is OR gate
    or gate2(out2, x, y); // Second gate

    // Assuming third gate is XOR gate
    xor gate3(z, out1, out2); // Third gate

endmodule
