module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // The first gate (AND gate)
    assign out1 = x & y;

    // The second gate (OR gate)
    assign out2 = x | y;

    // The third gate (XOR gate)
    assign z = out1 ^ out2;

endmodule
