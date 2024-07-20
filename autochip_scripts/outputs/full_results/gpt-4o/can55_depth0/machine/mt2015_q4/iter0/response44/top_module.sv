module top_module(
    input x,
    input y,
    output z
);
    wire first_gate_out;
    wire second_gate_out;

    // First gate (AND gate as an example)
    assign first_gate_out = x & y;

    // Second gate (OR gate as an example)
    assign second_gate_out = x | y;

    // Third gate (XOR gate as an example)
    assign z = first_gate_out ^ second_gate_out;

endmodule
