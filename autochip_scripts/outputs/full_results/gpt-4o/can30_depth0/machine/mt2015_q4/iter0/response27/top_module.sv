module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND gate for example)
    assign out1 = x & y;

    // Second gate (OR gate for example)
    assign out2 = x | y;

    // Third gate (XOR gate for example)
    assign z = out1 ^ out2;

endmodule
