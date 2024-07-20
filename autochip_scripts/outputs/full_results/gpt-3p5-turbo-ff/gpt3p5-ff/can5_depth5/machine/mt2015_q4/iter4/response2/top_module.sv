module top_module(
    input x,
    input y,
    output z);
    
    // Define internal wires
    wire a, b;
    
    // First gate
    and gate_1(a, x, y);
    
    // Second gate
    and gate_2(b, y, x);
    
    // Third gate
    not gate_3(z, a);  // Corrected gate_3 to be a not gate instead of xor gate
endmodule
