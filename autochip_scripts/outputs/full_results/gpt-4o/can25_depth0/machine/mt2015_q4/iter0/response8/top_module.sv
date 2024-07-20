module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;
    
    // First gate (AND)
    and gate1 (.a(x), .b(y), .y(out1));
    
    // Second gate (OR)
    or gate2 (.a(y), .b(x), .y(out2));
    
    // Third gate (XOR)
    xor gate3 (.a(out1), .b(out2), .y(z));

endmodule
