module top_module(
    input x,
    input y,
    output z);

    wire first_gate_out, second_gate_out;

    // First gate: AND gate
    assign first_gate_out = x & y;

    // Second gate: OR gate
    assign second_gate_out = x | y;

    // Third gate: XOR gate
    assign z = first_gate_out ^ second_gate_out;

endmodule
