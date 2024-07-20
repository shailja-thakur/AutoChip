module top_module(
    input x,
    input y,
    output z
);
    
    wire out1, out2;

    // First gate: assume AND gate
    assign out1 = x & y;

    // Second gate: assume OR gate
    assign out2 = x | y;

    // Third gate: assume XOR gate
    assign z = out1 ^ out2;

endmodule
