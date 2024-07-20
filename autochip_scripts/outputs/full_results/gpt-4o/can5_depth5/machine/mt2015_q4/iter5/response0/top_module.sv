module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND gate) - changed to AND gate
    assign out1 = x & y;

    // Second gate (OR gate) - changed to OR gate
    assign out2 = x | y;

    // Third gate (XOR gate) - changed to XOR gate for greater logic diversity
    assign z = out1 ^ out2;

endmodule
