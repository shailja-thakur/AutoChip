module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate, instance of AND gate
    and gate1(out1, x, y);

    // Second gate, instance of AND gate
    and gate2(out2, y, x);

    // Third gate, instance of AND gate
    and gate3(z, out1, out2);

endmodule
