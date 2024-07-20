module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;

    // First gate (AND gate for example)
    and first_gate(out1, x, y);

    // Second gate (OR gate for example)
    or second_gate(out2, y, x);

    // Third gate (XOR gate for example)
    xor third_gate(z, out1, out2);

endmodule
