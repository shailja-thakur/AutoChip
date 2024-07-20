module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate: AND gate
    and gate1(out1, x, y);

    // Second gate: OR gate
    or gate2(out2, y, x);

    // Third gate: combining the outputs of gate1 and gate2 using an OR gate
    or gate3(z, out1, out2);

endmodule
