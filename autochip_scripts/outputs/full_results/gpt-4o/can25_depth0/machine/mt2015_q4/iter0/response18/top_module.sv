module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;

    and and1 (out1, x, y);  // First gate: AND gate
    or or1 (out2, y, x);   // Second gate: OR gate
    xor xor1 (z, out1, out2); // Third gate: XOR gate

endmodule
