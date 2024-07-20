module top_module(
    input x,
    input y,
    output z);

    wire n1, n2;

    // First logic gate: AND gate
    assign n1 = x & y;

    // Second logic gate: OR gate
    assign n2 = x | y;

    // Third logic gate: XOR gate
    assign z = n1 ^ n2;

endmodule
