module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    and gate1 (out1, x, y);  // First gate with inputs x (a) and y (b)
    or  gate2 (out2, y, x);  // Second gate with inputs y (a) and x (b)
    xor gate3 (z, out1, out2);  // Third gate with inputs out1 (a) and out2 (b)

endmodule
