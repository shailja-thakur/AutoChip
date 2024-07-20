module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p1y, 
    output p2y
);

    // Logical AND operation on the first three inputs for p1y
    wire p1_and = p1a & p1b & p1c;
    
    // Logical OR operation on the last three inputs for p1y
    wire p1_or = p1d | p1e | p1f;
    
    // Result for p1y
    assign p1y = p1_and & p1_or;

    // Logical AND operation on the first two inputs for p2y
    wire p2_and = p2a & p2b;
    
    // Logical OR operation on the last two inputs for p2y
    wire p2_or = p2c | p2d;
    
    // Result for p2y
    assign p2y = p2_and & p2_or;

endmodule
