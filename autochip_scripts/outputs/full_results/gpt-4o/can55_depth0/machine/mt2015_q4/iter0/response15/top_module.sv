module top_module(
    input x,
    input y,
    output z
);
    wire out1, out2; // Wires to connect the outputs of the first and second gates to the inputs of the third gate.

    // First gate: AND gate
    assign out1 = x & y;

    // Second gate: OR gate
    assign out2 = x | y;

    // Third gate: XOR gate
    assign z = out1 ^ out2;
    
endmodule
