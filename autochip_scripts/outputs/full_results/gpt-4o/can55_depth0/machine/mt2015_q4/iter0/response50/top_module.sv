module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate: AND gate
    assign out1 = x & y;  // a=x, b=y

    // Second gate: OR gate
    assign out2 = x | y;  // b=x, a=y

    // Third gate: XOR gate
    assign z = out1 ^ out2;  // a=out1, b=out2

endmodule
