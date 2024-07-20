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

    // Implement the logical AND operation on the first three inputs (p1a, p1b, and p1c)
    wire p1_and = p1a & p1b & p1c;

    // Implement the logical OR operation on the last three inputs (p1d, p1e, and p1f)
    wire p1_or = p1d | p1e | p1f;

    // Assign the output p1y as the result of the logical AND and OR operations
    assign p1y = p1_and | p1_or;

    // Implement the logical AND operation on the first two inputs (p2a and p2b)
    wire p2_and = p2a & p2b;

    // Implement the logical OR operation on the last two inputs (p2c and p2d)
    wire p2_or = p2c | p2d;

    // Assign the output p2y as the result of the logical AND and OR operations
    assign p2y = p2_and | p2_or;

endmodule
