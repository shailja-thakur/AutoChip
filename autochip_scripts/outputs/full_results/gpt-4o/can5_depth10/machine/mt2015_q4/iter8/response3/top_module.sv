module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // The user didn't specify the type of logic gates correctly.
    // Let's assume AND gate for all three logic gates to make it consistent.

    and gate1(out1, x, y); // First gate
    and gate2(out2, y, x); // Second gate
    and gate3(z, out1, out2); // Third gate

endmodule
