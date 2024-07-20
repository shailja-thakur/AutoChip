module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Instantiate first gate: AND gate
    and and_gate1(out1, x, y);

    // Instantiate second gate: OR gate
    or or_gate2(out2, x, y);

    // Instantiate third gate: XOR gate
    xor xor_gate3(z, out1, out2);

endmodule
