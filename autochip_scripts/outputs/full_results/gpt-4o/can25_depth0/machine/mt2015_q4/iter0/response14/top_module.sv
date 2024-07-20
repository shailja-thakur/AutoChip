module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Instantiate the first logic gate (AND gate)
    assign out1 = x & y;

    // Instantiate the second logic gate (OR gate)
    assign out2 = x | y;

    // Instantiate the third logic gate (XOR gate)
    assign z = out1 ^ out2;

endmodule
