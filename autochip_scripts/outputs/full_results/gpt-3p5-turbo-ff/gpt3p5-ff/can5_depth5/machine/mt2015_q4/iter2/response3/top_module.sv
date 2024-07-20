module top_module(
    input x,
    input y,
    output z);
    
    // Define internal wires
    wire a, b;
    
    // First gate
    xor gate_1(a, x, y);
    
    // Second gate
    xor gate_2(b, x, y);
    
    // Third gate
    xor gate_3(z, a, b);
endmodule
