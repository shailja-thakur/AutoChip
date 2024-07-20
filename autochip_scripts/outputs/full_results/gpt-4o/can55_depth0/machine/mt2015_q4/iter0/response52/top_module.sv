module top_module(
    input x,
    input y,
    output z);

    wire result1, result2;

    // First gate (AND)
    assign result1 = x & y;

    // Second gate (OR)
    assign result2 = x | y;

    // Third gate (XOR)
    assign z = result1 ^ result2;

endmodule
