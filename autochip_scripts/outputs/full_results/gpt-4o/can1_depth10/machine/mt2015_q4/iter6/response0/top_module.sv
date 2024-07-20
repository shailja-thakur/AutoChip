module top_module(
    input x,
    input y,
    output z);

    wire w1, w2;

    // First gate (AND gate)
    assign w1 = x & y;

    // Second gate (OR gate)
    assign w2 = x | y;

    // Third gate (XOR gate)
    assign z = w1 ^ w2;

endmodule
