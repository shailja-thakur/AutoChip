module top_module(
    input x,
    input y,
    output z
);

    // First gate
    wire a1, b1;
    assign a1 = x;
    assign b1 = y;
    
    // Second gate
    wire a2, b2;
    assign a2 = y;
    assign b2 = x;
    
    // Third gate
    wire a3, b3;
    assign a3 = a1;
    assign b3 = b2;
    
    // Output gate
    assign z = (a3 & b3);

endmodule
