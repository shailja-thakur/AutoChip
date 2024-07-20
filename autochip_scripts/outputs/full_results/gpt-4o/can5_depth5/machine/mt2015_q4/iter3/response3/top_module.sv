module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (could be an AND gate)
    assign out1 = x & y;

    // Second gate (could be an OR gate)
    assign out2 = x | y;

    // Third gate (could be an XOR gate)
    assign z = out1 ^ out2;

endmodule
