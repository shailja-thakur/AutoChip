module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate, using AND
    assign out1 = x & y;

    // Second gate, using OR
    assign out2 = x | y;

    // Third gate, using XOR
    assign z = out1 ^ out2;

endmodule
