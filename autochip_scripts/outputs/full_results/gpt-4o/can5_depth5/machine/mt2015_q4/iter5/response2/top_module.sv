module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND gate)
    assign out1 = x & y;

    // Second gate (OR gate using swapped inputs)
    assign out2 = x | y;

    // Third gate (XOR gate with outputs of first and second gates)
    assign z = out1 ^ out2;

endmodule
