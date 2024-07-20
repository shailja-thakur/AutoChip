module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (could be AND gate)
    assign out1 = x & y;

    // Second gate (could be OR gate)
    assign out2 = x | y;

    // Third gate (XOR gate)
    assign z = out1 ^ out2;

endmodule
