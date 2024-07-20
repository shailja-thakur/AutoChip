module top_module(
    input x,
    input y,
    output z);
    
    // Define internal wires
    wire a, b;
    
    // First gate
    assign a = x & ~y;
    
    // Second gate
    assign b = ~x & y;
    
    // Third gate
    assign z = a & b;
    
endmodule
