module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;
    
    assign a = x & ~y;  // First gate
    assign b = ~x & y;  // Second gate
    
    assign z = a ^ b;   // Third gate

endmodule
