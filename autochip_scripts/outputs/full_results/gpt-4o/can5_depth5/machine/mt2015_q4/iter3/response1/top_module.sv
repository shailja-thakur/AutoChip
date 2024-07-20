module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // According to the given specification,
    // we will use the following gates: 
    // First gate: AND gate
    // Second gate: OR gate
    // Third gate: XOR gate

    // First gate
    assign out1 = x & y; // AND gate

    // Second gate
    assign out2 = x | y; // OR gate

    // Third gate
    assign z = out1 ^ out2; // XOR gate

endmodule
