module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;
    
    // First gate: AND gate
    and (out1, x, y);
    
    // Second gate: OR gate
    or (out2, y, x);
    
    // Third gate: XOR gate
    xor (z, out1, out2);
    
endmodule
