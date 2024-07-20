module top_module(
    input x,
    input y,
    output z
);

    wire out1, out2;
    
    // First gate (AND gate)
    and and1(out1, x, y);
    
    // Second gate (OR gate)
    or or1(out2, x, y);
    
    // Third gate (XOR gate)
    xor xor1(z, out1, out2);

endmodule
