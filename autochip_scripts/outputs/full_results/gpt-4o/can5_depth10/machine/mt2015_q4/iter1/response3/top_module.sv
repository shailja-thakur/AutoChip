module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Assuming the first gate is AND gate
    and and_gate1(out1, x, y);

    // Assuming the second gate is OR gate
    or  or_gate2(out2, y, x);

    // Assuming the third gate is XOR gate
    xor xor_gate3(z, out1, out2);

endmodule
