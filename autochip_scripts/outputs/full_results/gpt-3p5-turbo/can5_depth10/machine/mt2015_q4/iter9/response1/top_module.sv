module top_module(
    input wire x,
    input wire y,
    output wire z
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
    wire z_temp;
    assign z_temp = a1 & ~b2;
    assign z = z_temp;

endmodule
