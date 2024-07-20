module top_module(
    input x,
    input y,
    output z);

    wire first_gate_output;
    wire second_gate_output;
    
    // First gate (AND gate as an example)
    and first_gate(first_gate_output, x, y);
    
    // Second gate (OR gate as an example)
    or second_gate(second_gate_output, y, x);

    // Third gate (XOR gate as an example)
    xor third_gate(z, first_gate_output, second_gate_output);

endmodule
