module top_module(
    input x,
    input y,
    output z);

    wire gate1_out;
    wire gate2_out;

    // First gate, let's assume it's an AND gate
    assign gate1_out = x & y;

    // Second gate, let's assume it's an OR gate
    assign gate2_out = x | y;

    // Third gate, let's assume it's a XOR gate
    assign z = gate1_out ^ gate2_out;

endmodule
