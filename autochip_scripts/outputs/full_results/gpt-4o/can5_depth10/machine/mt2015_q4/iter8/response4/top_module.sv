module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Correct gates according to the logical specification
    and gate1(out1, x, y);   // First gate is an AND gate
    or gate2(out2, y, x);    // Second gate is an OR gate
    xor gate3(z, out1, out2); // Third gate is an XOR gate, taking outputs of gate1 and gate2

endmodule
