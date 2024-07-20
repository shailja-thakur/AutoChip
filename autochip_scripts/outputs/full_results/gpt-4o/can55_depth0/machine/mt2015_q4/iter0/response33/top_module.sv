module top_module(
    input x,
    input y,
    output z);

    wire gate1_out, gate2_out;

    // First gate (AND gate)
    assign gate1_out = x & y;

    // Second gate (OR gate)
    assign gate2_out = x | y;

    // Third gate (XOR gate)
    assign z = gate1_out ^ gate2_out;

endmodule
