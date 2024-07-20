module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    output p1y,
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

    // Intermediate signals
    wire p1_and;
    wire p1_or;
    wire p2_and;
    wire p2_or;

    // Combinational logic to calculate p1_and and p1_or
    assign p1_and = p1a & p1b & p1c;
    assign p1_or = p1d | p1e | p1f;
    
    // Output assignment for p1y
    assign p1y = p1_and & p1_or;

    // Combinational logic to calculate p2_and and p2_or
    assign p2_and = p2a & p2b;
    assign p2_or = p2c | p2d;
    
    // Output assignment for p2y
    assign p2y = p2_and & p2_or;

endmodule
