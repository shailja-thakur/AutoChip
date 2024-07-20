module top_module(
    input x,
    input y,
    output z);

    wire out_first_gate;
    wire out_second_gate;

    // First gate: AND gate
    assign out_first_gate = x & y;

    // Second gate: OR gate
    assign out_second_gate = x | y;

    // Third gate: XOR gate
    assign z = out_first_gate ^ out_second_gate;

endmodule
