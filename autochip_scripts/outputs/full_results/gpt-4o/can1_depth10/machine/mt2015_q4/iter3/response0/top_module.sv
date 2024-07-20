module top_module(
    input x,
    input y,
    output z);

    wire w1, w2;

    // First gate (AND gate)
    assign w1 = x & y;

    // Second gate (AND gate)
    assign w2 = x & y;

    // Third gate (OR gate)
    assign z = w1 | w2;

endmodule
