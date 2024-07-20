module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Let's use different logic gates keeping the observation in mind

    and gate1(out1, x, y); // First gate is AND gate
    or gate2(out2, x, y); // Second gate is OR gate
    xor gate3(z, out1, out2); // Third gate is XOR gate

endmodule
