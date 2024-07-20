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
    // Output p1y: logical AND operation on inputs p1a, p1b, and p1c
    assign p1y = p1a & p1b & p1c;

    // Output p2y: logical AND operation on inputs p2a and p2b
    assign p2y = p2a & p2b;

    // Combining inputs p1d, p1e, and p1f with logical OR to compute p1y
    assign p1y = p1y | p1d | p1e | p1f;

    // Combining inputs p2c and p2d with logical OR to compute p2y
    assign p2y = p2y | p2c | p2d;

endmodule
