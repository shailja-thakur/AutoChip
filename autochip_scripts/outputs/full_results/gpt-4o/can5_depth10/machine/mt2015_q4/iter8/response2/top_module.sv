module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    and gate1(out1, x, y); // First gate
    or gate2(out2, y, x);  // Second gate
    xor gate3(z, out1, out2); // Third gate that combines the outputs of the first two gates

endmodule
