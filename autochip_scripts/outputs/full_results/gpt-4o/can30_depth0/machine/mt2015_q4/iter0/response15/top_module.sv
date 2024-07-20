module top_module(
    input x,
    input y,
    output z
);
    wire out1, out2; // Intermediate wires

    and gate1 (.a(x), .b(y), .out(out1)); // First gate (AND)
    or  gate2 (.a(y), .b(x), .out(out2)); // Second gate (OR)
    xor gate3 (.a(out1), .b(out2), .out(z)); // Third gate (XOR)

endmodule
