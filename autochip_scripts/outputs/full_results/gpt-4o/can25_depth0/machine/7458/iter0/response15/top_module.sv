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

    // Logical AND operation on the first three inputs (p1a, p1b, and p1c)
    wire p1_and = p1a & p1b & p1c;
    
    // Logical OR operation on the last three inputs (p1d, p1e, and p1f)
    wire p1_or = p1d | p1e | p1f;
    
    // Resulting output p1y is AND of p1_and and p1_or
    assign p1y = p1_and & p1_or;
    
    // Logical AND operation on the first two inputs (p2a, p2b)
    wire p2_and = p2a & p2b;
    
    // Logical OR operation on the last two inputs (p2c, p2d)
    wire p2_or = p2c | p2d;
    
    // Resulting output p2y is AND of p2_and and p2_or
    assign p2y = p2_and & p2_or;

endmodule
