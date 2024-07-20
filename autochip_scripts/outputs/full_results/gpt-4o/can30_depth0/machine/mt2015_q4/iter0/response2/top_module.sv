module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First logic gate
    and gate1 (out1, x, y); // Assuming AND gate for the first logic gate

    // Second logic gate
    or gate2 (out2, y, x); // Assuming OR gate for the second logic gate

    // Third logic gate
    xor gate3 (z, out1, out2); // Assuming XOR gate for the third logic gate

endmodule
